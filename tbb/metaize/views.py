
from django.http import HttpResponse
from django.template import RequestContext
from djangoxslt.xslt import render_to_response
from django.shortcuts import get_object_or_404
from models import Episode
from models import Moment
from django import forms
from django.forms.util import ValidationError

class CommentForm(forms.Form):
    episode = forms.IntegerField(forms.HiddenInput)
    time = forms.IntegerField(forms.HiddenInput)
    comment = forms.CharField(widget=forms.Textarea)
    author = forms.CharField()

import logging
logging.basicConfig()
logging.getLogger("").setLevel(logging.DEBUG)

def episode_comment(request, episode):
    """Add a comment for the episode."""

    data = request.POST.copy()
    comment_request = CommentForm(data)
    if not comment_request.is_valid():
        raise ValidationError("validation failed")

    comment = Moment(
        episode=Episode.objects.get(id=int(comment_request.cleaned_data["episode"])),
        time=int(comment_request.cleaned_data["time"]),
        author=comment_request.cleaned_data["author"],
        comment=comment_request.cleaned_data["comment"]
        )
    comment.save()

    response = HttpResponse(status=201)
    response["Location"] = "%s/%s" % (request.path_info, comment.id)
    return response

def episode(request, name):
    """Render an episode by name"""
    episode = get_object_or_404(Episode, name=name)
    if request.method == "POST":
        return episode_comment(request, episode)

    ctx = RequestContext(request, {
            "episode": episode,
            "comment": CommentForm(),
            })
    return render_to_response("episode.xslt", ctx)

def list(request):
    """Render a list of episodes"""
    ctx = RequestContext(request, {
            "episodes": Episode.objects.all().xml(
                name="name",
                url="url"
                )
            })
    return render_to_response("episodelist.xslt", ctx)

# End
