abstract class ILoadService {
  void refreshData();
  void loadMoreData();
  void refreshAndLoadCtl(bool isRefresh, int size);
  void refreshList();
  void loadMoreList();
  void refreshAndLoadListCtl(bool isRefresh, int size);
}
