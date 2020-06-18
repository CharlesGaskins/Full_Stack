# Step 6
from django.http import HttpResponse
from django.http import HttpResponseRedirect# <--------added in step 33
from django.shortcuts import render  # <--------added in step 27
from django.shortcuts import get_object_or_404  # <--------added in step 28
from django.urls import reverse# <--------added in step 33
from django.views import generic # <--------added in step 36
from django.utils import timezone

from .models import Question# <--------added in step 23
from .models import Choice# <--------added in step 33


# Step 23: New View
# def index(request):
#     latest_question_list = Question.objects.order_by('-pub_date')[:5]
#     context = {
#         'latest_question_list': latest_question_list,  # <--------added in step 27
#     }
#     return render(request, 'polls/index.html', context)  # <--------added in step 27

#UPDATED TO DJANGO'S GENERIC VIEWS IN STEP 36
class IndexView(generic.ListView):
    template_name = 'polls/index.html'   #<----STEP 36
    context_object_name = 'latest_question_list'

    def get_queryset(self):
        """Return the last five published questions (not including those set to be
    published in the future)"""
        return Question.objects.filter(
            pub_date__lte=timezone.now()
        ).order_by('-pub_date')[:5]

class DetailView(generic.DetailView):
    model = Question             #<----STEP 36
    template_name = 'polls/detail.html'
    def get_queryset(self):
        """
        Excludes any questions that aren't published yet.
        """
        return Question.objects.filter(pub_date__lte=timezone.now())

class ResultsView(generic.DetailView):
    model = Question            #<----STEP 36
    template_name = 'polls/results.html'

#THE BELOW CODE HAS BEEN UPDATED TO DJANGOS GENERIC VIEWS
# # Step 23: New View, question_id == new argument
# def detail(request, question_id):
#     question = get_object_or_404(Question, pk=question_id)# <--------added in step 28
#     return render(request, 'polls/detail.html', {'question': question})# <--------added in step 28
#
#
# # Step 23: New View, question_id == new argument
# def results(request, question_id):
#     # response = "You're looking at the results of the question %s."
#     # return HttpResponse(response % question_id)
#     question = get_object_or_404(Question, pk=question_id)# <--------added in step 33
#     return render(request, 'polls/results.html', {'question': question})# <--------added in step 33


# Step 23: New View, question_id == new argument
def vote(request, question_id):
    # return HttpResponse("You're voting on question %s." % question_id)
    question = get_object_or_404(Question, pk=question_id)# <--------added in step 33
    try:# <--------added in step 33
        selected_choice = question.choice_set.get(pk=request.POST['choice'])# <--------added in step 33
    except (KeyError, Choice.DoesNotExist):# <--------added in step 33
        #REDISPLAYS THE QUESTION VOTING FORM
        return render(request, 'polls/detail.html', { # <--------added in step 33
            'question': question,# <--------added in step 33
            'error_message': "You didn't select a choice.",# <--------added in step 33
        })
    else:# <--------added in step 33
        selected_choice.votes += 1# <--------added in step 33
        selected_choice.save()# <--------added in step 33
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))# <--------added in step 33