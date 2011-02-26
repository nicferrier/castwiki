
from django.test import TestCase
from django.test.client import Client
from djangoxslt.xslt.testhelp import assertXpath
from models import Episode

class SimpleTest(TestCase):

    def test_get_list(self):
        c = Client()
        response = c.get("/e/")
        self.assert_(response.status_code == 200)
        assertXpath(response.content, "//ul//li", html=True)
    
    def test_get_episode(self):
        # We're actually loading this with the fixture
        #url = "http://dl.dropbox.com/u/10330141/TechGrumps_024.mp3"
        #episode = Episode(
        #    name="techgrumps_024",
        #    url=url
        #    )
        #episode.save()
        c = Client()
        response = c.get("/e/%s" % "techgrumps_024")
        self.assert_(response.status_code == 200)

# End
