# Assign themes only if no other theme exists yet
./manage.py lms shell -c "
import sys
from django.contrib.sites.models import Site
def assign_theme(domain):
    site, _ = Site.objects.get_or_create(domain=domain)
    if not site.themes.exists():
        site.themes.create(theme_dir_name='indigo')

assign_theme('learning.ncert.gov.in')
assign_theme('learning.ncert.gov.in')
assign_theme('learning.ncert.gov.in:8000')
assign_theme('studio.learning.ncert.gov.in')
assign_theme('studio.learning.ncert.gov.in:8001')
assign_theme('preview.learning.ncert.gov.in')
assign_theme('preview.learning.ncert.gov.in:8000')
"