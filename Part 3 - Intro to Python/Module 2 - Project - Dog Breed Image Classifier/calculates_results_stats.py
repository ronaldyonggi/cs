#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# */AIPND-revision/intropyproject-classify-pet-images/calculates_results_stats.py
#                                                                             
# PROGRAMMER: Ronald Yonggi    
# DATE CREATED: September 4th, 2020                  
# REVISED DATE: 
# PURPOSE: Create a function calculates_results_stats that calculates the 
#          statistics of the results of the programrun using the classifier's model 
#          architecture to classify the images. This function will use the 
#          results in the results dictionary to calculate these statistics. 
#          This function will then put the results statistics in a dictionary
#          (results_stats_dic) that's created and returned by this function.
#          This will allow the user of the program to determine the 'best' 
#          model for classifying the images. The statistics that are calculated
#          will be counts and percentages. Please see "Intro to Python - Project
#          classifying Images - xx Calculating Results" for details on the 
#          how to calculate the counts and percentages for this function.    
#         This function inputs:
#            -The results dictionary as results_dic within calculates_results_stats 
#             function and results for the function call within main.
#         This function creates and returns the Results Statistics Dictionary -
#          results_stats_dic. This dictionary contains the results statistics 
#          (either a percentage or a count) where the key is the statistic's 
#           name (starting with 'pct' for percentage or 'n' for count) and value 
#          is the statistic's value.  This dictionary should contain the 
#          following keys:
#            n_images - number of images
#            n_dogs_img - number of dog images
#            n_notdogs_img - number of NON-dog images
#            n_match - number of matches between pet & classifier labels
#            n_correct_dogs - number of correctly classified dog images
#            n_correct_notdogs - number of correctly classified NON-dog images
#            n_correct_breed - number of correctly classified dog breeds
#            pct_match - percentage of correct matches
#            pct_correct_dogs - percentage of correctly classified dogs
#            pct_correct_breed - percentage of correctly classified dog breeds
#            pct_correct_notdogs - percentage of correctly classified NON-dogs
#
##
# TODO 5: Define calculates_results_stats function below, please be certain to replace None
#       in the return statement with the results_stats_dic dictionary that you create 
#       with this function
# 
def calculates_results_stats(results_dic):
    """
    Calculates statistics of the results of the program run using classifier's model 
    architecture to classifying pet images. Then puts the results statistics in a 
    dictionary (results_stats_dic) so that it's returned for printing as to help
    the user to determine the 'best' model for classifying images. Note that 
    the statistics calculated as the results are either percentages or counts.
    Parameters:
      results_dic - Dictionary with key as image filename and value as a List 
             (index)idx 0 = pet image label (string)
                    idx 1 = classifier label (string)
                    idx 2 = 1/0 (int)  where 1 = match between pet image and 
                            classifer labels and 0 = no match between labels
                    idx 3 = 1/0 (int)  where 1 = pet image 'is-a' dog and 
                            0 = pet Image 'is-NOT-a' dog. 
                    idx 4 = 1/0 (int)  where 1 = Classifier classifies image 
                            'as-a' dog and 0 = Classifier classifies image  
                            'as-NOT-a' dog.
    Returns:
     results_stats_dic - Dictionary that contains the results statistics (either
                    a percentage or a count) where the key is the statistic's 
                     name (starting with 'pct' for percentage or 'n' for count)
                     and the value is the statistic's value. See comments above
                     and the classroom Item XX Calculating Results for details
                     on how to calculate the counts and statistics.
    """        

    results_stats = {}
    # Initiate total number of images
    results_stats['n_images'] = 0
    # Initiate number of correctly classified dog images
    results_stats['n_correct_dogs'] = 0
    # Initiate number dog images
    results_stats['n_dogs_img'] = 0
    # Initiate number of correctly classified non-dog images
    results_stats['n_correct_notdogs'] = 0
    # Initiate number of non-dog images
    results_stats['n_notdogs_img'] = 0
    # Initiate number of correct breed matches
    results_stats['n_correct_breed'] = 0
    # Initiate number of matches between pet & classifier label
    results_stats['n_match'] = 0
    # Initiate percentage of correct matches
    results_stats['pct_match'] = float(0)
    # Initiate percentage of correctly classified dogs
    results_stats['pct_correct_dogs'] = float(0)
    # Initiate percentage of correctly classified dog breeds
    results_stats['pct_correct_breed'] = float(0)
    # Initiate percentage of correctly classified non-dogs
    results_stats['pct_correct_notdogs'] = float(0)

    for value in results_dic.values():
        # For every iteration of results_dic, increment number of images
        results_stats['n_images'] += 1
        # If both pet label and classifier are dogs (both values 1), increment by 1
        if value[3] + value[4] == 2:
            results_stats['n_correct_dogs'] += 1
        # Pet label index is either 0 or 1, simply increment by the pet label index.
        results_stats['n_dogs_img'] += value[3]
        # If both pet label and classifier are non-dog (both values 0), increment by 1
        if not (value[3] + value[4]):
            results_stats['n_correct_notdogs'] += 1
        # If the pet label is a dog and the labels match, count as correct breed match
        if (value[2] + value[3]) == 2:
            results_stats['n_correct_breed'] += 1
        # Label matches is either 0 or 1, simply increment.
        results_stats['n_match'] += value[2]

    # Count of non-dog image is total number of image subtracted by count of dog images
    results_stats['n_notdogs_img'] = results_stats['n_images'] - results_stats['n_dogs_img']

    # Calculates percentage of correctly classified dog images
    results_stats['pct_correct_dogs'] = (results_stats['n_correct_dogs'] / results_stats['n_dogs_img']) * 100
    # Calculates percentage of correctly classified non-dog images. 
    # If the count of nondog images is 0, set the percentage to be 0
    if not results_stats['n_notdogs_img']:
        results_stats['pct_correct_notdogs'] = 0
    else:
        results_stats['pct_correct_notdogs'] = (results_stats['n_correct_notdogs'] / results_stats['n_notdogs_img']) * 100
    # Percentage of correctly classified dog breeds
    results_stats['pct_correct_breed'] = (results_stats['n_correct_breed'] / results_stats['n_dogs_img']) * 100
    # Percentage of label matches
    results_stats['pct_match'] = (results_stats['n_match'] / results_stats['n_images'])*100

    # Replace None with the results_stats_dic dictionary that you created with 
    # this function 
    return results_stats
