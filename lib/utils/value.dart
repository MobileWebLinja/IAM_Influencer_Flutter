import 'dart:io';

int profile_opentab;
bool checked = false;
List data_allcampagins;
List items = List();
int perPage = 5;
int present = 0;
List data_active;
List active_items = List();
int active_perPage = 5;
int active_present = 0;
List data_mycampaigns_invitation;
List mycampaigns_invitation_items = List();
int mycampaigns_invitation_perPage = 5;
int mycampaigns_invitation_present = 0;

List data_mycampaigns_waiting;
List mycampaigns_waiting_items = List();
int mycampaigns_waiting_perPage = 5;
int mycampaigns_waiting_present = 0;

List data_mycampaigns_finished;
List mycampaigns_finished_items = List();
int mycampaigns_finished_perPage = 5;
int mycampaigns_finished_present = 0;

List data_mycampaigns_favorite;
List mycampaigns_favorite_items = List();
int mycampaigns_favorite_perPage = 5;
int mycampaigns_favorite_present = 0;
String detailcampaign_url =
    "https://web.iam.id/iam-mobile/api/influencer/campaign/detail";
String guarantee_reach = "";
String engagement_rate = "";
String est_reach_post = "";
String est_reach_story = "";
String est_low_price = "";
String est_high_price = "";
String profile_avatar = "";
String profile_background = "";
String profile_post_count = "";
String profile_regencies_name = "";
String profile_followers = "";
String profile_following = "";
String profile_full_name = "";
String profile_niche;
List<String> niche = List<String>();
String edit_fullname;
String edit_gender;
String edit_email;
String birthday;
String edit_handphone;
String edit_workplace;
String edit_religious;
String edit_provinsi;
String edit_kota;
String edit_location;
List data_detail_campaign;
List data_invitations;
List data_upcoming;
List data_search;
List data_provinsi;
List data_kota;
List data_kota_edit;
List data_notifikasi;
List items_notifi = List();
List<String> provinsi = new List<String>();
List<String> gender = ["Laki-laki", "Perempuan"];
List<String> religion = ["Islam", "Katolik", "Protestan", "Hindu", "Budha"];
List<String> kota = new List<String>();
List<String> kota_edit_profile = new List<String>();
String release_date;
int detail_campaign_id;
List items_upcoming = List();
List items_search = List();
String search = "";
List items_invitations = List();
bool start = true;
bool start_upcoming = true;
bool loged = false;
int starValue = 1000;
int endValue = 5000;
String token;
int perPage_upcoming = 5;
int present_upcoming = 0;

int invitation_perPage = 5;
int invitation_present = 0;
List<String> selectedReportList_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> selectedReportList_gender = [
  "Male",
  "Female",
];
List<String> selectedReportList_status = [
  "ongoing",
  "finished",
];
List<String> selectedChoices_state = [
  "ongoing",
  "finished",
];
List<String> selectedChoices_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> selectedChoices_gender = [
  "Male",
  "Female",
];
int open_tab;
int open_tab_detail;
int mycampaigns_open_tab;
List<String> upcoming_selectedReportList_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> upcoming_selectedReportList_gender = [
  "Male",
  "Female",
];
List<String> upcoming_selectedReportList_status = [
  "ongoing",
  "finished",
];
List<String> upcoming_selectedChoices_state = [
  "ongoing",
  "finished",
];
List<String> upcoming_selectedChoices_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> upcoming_selectedChoices_gender = [
  "Male",
  "Female",
];

List<String> invitation_selectedReportList_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> invitation_selectedReportList_gender = [
  "Male",
  "Female",
];
List<String> invitation_selectedReportList_status = [
  "ongoing",
  "finished",
];
List<String> invitation_selectedChoices_state = [
  "ongoing",
  "finished",
];
List<String> invitation_selectedChoices_category = [
  "Parenting",
  "Entertaiment",
  "Health & Sport",
  "Lifestyle & Travel",
  "Fashion",
  "Technology",
  "Beauty",
  "Food",
  "Other"
];
List<String> invitation_selectedChoices_gender = [
  "Male",
  "Female",
];

List data_timeline;
List items_timeline = List();

List data_activity;
List items_activity = List();

String activity_logo = "";
String activity_name = "";
String activity_status = "";
String activity_date = "";

String caption = "";
bool select_foto_feed;
bool select_foto_story;
