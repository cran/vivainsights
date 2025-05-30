# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Sample Person Query dataset
#'
#' @description
#' A dataset generated from a Person Query from Viva Insights.
#'
#' @family Data
#'
#' @return data frame.
#'
#' @format A data frame with 6900 rows and 73 variables:
#' \describe{
#' \item{PersonId}{}
#' \item{MetricDate}{}
#' \item{Collaboration_hours}{}
#' \item{Copilot_actions_taken_in_Teams}{}
#' \item{Meeting_and_call_hours}{}
#' \item{Internal_network_size}{}
#' \item{Email_hours}{}
#' \item{Channel_message_posts}{}
#' \item{Conflicting_meeting_hours}{}
#' \item{Large_and_long_meeting_hours}{}
#' \item{External_collaboration_hours}{}
#' \item{Active_connected_hours}{}
#' \item{Meetings}{}
#' \item{After_hours_collaboration_hours}{}
#' \item{Call_hours}{}
#' \item{Calls}{}
#' \item{Channel_message_hours}{}
#' \item{Chat_hours}{}
#' \item{Collaboration_span}{}
#' \item{Emails_read}{}
#' \item{Emails_sent}{}
#' \item{External_network_size}{}
#' \item{Meeting_and_call_hours_with_manager}{}
#' \item{Meeting_and_call_hours_with_manager_1_1}{}
#' \item{Meeting_and_call_hours_with_skip_level}{}
#' \item{Meeting_hours}{}
#' \item{Multitasking_hours}{}
#' \item{Network_outside_company}{}
#' \item{Network_outside_organisation}{}
#' \item{Time_with_leadership}{}
#' \item{Unscheduled_call_hours}{}
#' \item{Weekend_collaboration_hours}{}
#' \item{Copilot_actions_taken_in_Copilot_chat__work_}{}
#' \item{Copilot_actions_taken_in_Excel}{}
#' \item{Copilot_actions_taken_in_Outlook}{}
#' \item{Copilot_actions_taken_in_Powerpoint}{}
#' \item{Copilot_actions_taken_in_Word}{}
#' \item{Days_of_active_Copilot_chat__work__usage}{}
#' \item{Days_of_active_Copilot_usage_in_Excel}{}
#' \item{Days_of_active_Copilot_usage_in_Loop}{}
#' \item{Days_of_active_Copilot_usage_in_OneNote}{}
#' \item{Days_of_active_Copilot_usage_in_Outlook}{}
#' \item{Days_of_active_Copilot_usage_in_Powerpoint}{}
#' \item{Days_of_active_Copilot_usage_in_Teams}{}
#' \item{Days_of_active_Copilot_usage_in_Word}{}
#' \item{Total_Copilot_active_days}{}
#' \item{Total_Copilot_enabled_days}{}
#' \item{Barriers_to_Execution}{}
#' \item{Change_Adaptation}{}
#' \item{Collaboration}{}
#' \item{Communication_Flow}{}
#' \item{Continuous_Improvement}{}
#' \item{eSat}{}
#' \item{Initiative}{}
#' \item{Manager_Recommend}{}
#' \item{Resources}{}
#' \item{Speak_My_Mind}{}
#' \item{Wellbeing}{}
#' \item{Work_Life_Balance}{}
#' \item{Workload}{}
#' \item{Create_Excel_formula_actions_taken_using_Copilot}{}
#' \item{Create_presentation_actions_taken_using_Copilot}{}
#' \item{Generate_email_draft_actions_taken_using_Copilot_in_Outlook}{}
#' \item{Summarise_chat_actions_taken_using_Copilot_in_Teams}{}
#' \item{Summarise_email_thread_actions_taken_using_Copilot_in_Outlook}{}
#' \item{Summarise_meeting_actions_taken_using_Copilot_in_Teams}{}
#' \item{Summarise_presentation_actions_taken_using_Copilot_in_PowerPoint}{}
#' \item{Summarise_Word_document_actions_taken_using_Copilot_in_Word}{}
#' \item{FunctionType}{}
#' \item{SupervisorIndicator}{}
#' \item{Level}{}
#' \item{Organization}{}
#' \item{LevelDesignation}{}
#' }
#' @source \url{https://learn.microsoft.com/en-us/viva/insights/advanced/analyst/person-query/}
"pq_data"