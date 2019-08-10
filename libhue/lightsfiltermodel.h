#ifndef LIGHTSFILTERMODEL_H
#define LIGHTSFILTERMODEL_H

#include <QSortFilterProxyModel>

class Group;
class Groups;
class Lights;
class Light;

class LightsFilterModel: public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(int groupId READ groupId WRITE setGroupId NOTIFY groupIdChanged)
    Q_PROPERTY(Lights* lights READ lights WRITE setLights NOTIFY lightsChanged)
    Q_PROPERTY(FilterRoleOn filterRoleOn READ filterRoleOn WRITE setFilterRoleOn NOTIFY filterRoleOnChanged)
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum FilterRoleOn {
        ShowAll,
        ShowOn,
        ShowOff
    };
    Q_ENUM(FilterRoleOn)

    LightsFilterModel(QObject *parent = 0);

    int groupId() const;
    void setGroupId(int groupId);

    Lights* lights() const;
    void setLights(Lights *lights);

    Q_INVOKABLE Light* get(int row) const;

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;

    Q_INVOKABLE void hideLight(int id);
    Q_INVOKABLE void showLight(int id);

    FilterRoleOn filterRoleOn() const;
    void setFilterRoleOn(FilterRoleOn filter);

    int count() const { return rowCount(QModelIndex()); }

signals:
    void groupIdChanged();
    void lightsChanged();
    void filterRoleOnChanged();
    void countChanged();

private slots:
    void groupChanged(const QModelIndex &first, const QModelIndex &last, const QVector<int> &roles);
    void groupsAdded(const QModelIndex &parent, int first, int last);
    void groupsReset();

private:
    Group* findGroup();

private:
    quint16 m_groupId;
    Group *m_group;
    Groups *m_groups;
    Lights *m_lights;
    FilterRoleOn m_filterRoleOn;

    QList<int> m_hiddenLights;
};

#endif
