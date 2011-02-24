from django.contrib import admin

from models import Episode
from models import Moment

class EpisodeAdmin(admin.ModelAdmin):
    list_display = ('name', 'url', 'id')
    list_filter = ('name',)

class MomentAdmin(admin.ModelAdmin):
    list_display = ('episode', 'time', 'comment', 'author', 'id')
    list_filter = ('episode', 'time',)
    

admin.site.register(Moment, MomentAdmin)
admin.site.register(Episode, EpisodeAdmin)

# End
