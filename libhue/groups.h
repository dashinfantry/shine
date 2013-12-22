/*
 * Copyright 2013 Christian Muehlhaeuser
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 2.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *      Christian Muehlhaeuser <muesli@gmail.com>
 */

#ifndef GROUPS_H
#define GROUPS_H

#include <QAbstractListModel>

class Group;

class Groups : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        RoleId,
        RoleName,
        RoleOn,
        RoleBrightness,
        RoleHue,
        RoleSaturation,
        RoleXY,
        RoleAlert,
        RoleEffect,
        RoleColorMode,
        RoleReachable
    };

    explicit Groups(QObject *parent = 0);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE Group* get(int index) const;

public slots:
    void refresh();

private slots:
    void groupsReceived(int id, const QVariant &variant);
    void groupDescriptionChanged();
    void groupStateChanged();

private:
    Group* createGroup(int id, const QString &name);

private:
    QList<Group*> m_list;
};

#endif // GROUPS_H
