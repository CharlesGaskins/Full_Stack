# Step 7 B
from django.urls import path#<-------- Code from 7B

from . import views#<-------- Code from 7B

app_name = 'polls'#<----added in step 30
urlpatterns = [
    # #ex: /<app name>/
    # path('', views.index, name='index'),#<-------- Code from 7B
    # #ex: /<app name>/5/
    # # path('<int:question_id>/', views.detail, name='detail'),#<-------- Code from 24
    # path('<int:question_id>/', views.detail, name='detail'),#<-------- Updated in step 31
    # #ex: /<app name>/5/results/
    # path('<int:question_id>/results/', views.results, name='results'),#<-------- Code from 24
    # #ex: /<app name>/5/vote
    # path('<int:question_id>/vote/', views.vote, name='vote'),#<-------- Code from 24

    #UPDATED PATHS IN STEP 35
    path('', views.IndexView.as_view(), name='index'),
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    path('<int:pk>/results/', views.ResultsView.as_view(), name="results"),
    path('<int:question_id>/vote/', views.vote, name='vote'),

]