from django.db import models
from datetime import datetime

# Create your models here.

class Episode(models.Model):
    url = models.URLField(max_length=2000)
    name = models.TextField()
    description = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.name

class Moment(models.Model):
    episode = models.ForeignKey(Episode)
    created = models.DateTimeField(default=datetime.now)
    time = models.PositiveIntegerField()
    comment = models.TextField()
    author = models.CharField(max_length=100) # This should be oauth link


# End
