#ifndef NAVIGATIONCONTROLLER_H
#define NAVIGATIONCONTROLLER_H

#include <QObject>
#include <QQuickItem>

#include "Documentation.h"

/** \brief Exposes a list of items with the Documentation attachted property by traversing the QML view hierarchy
 * \note to be used in conjunction with DocumentationOverlay.qml
 */
class DocumentationController : public QObject
{
    Q_OBJECT

    // Construction
public:
    using QObject::QObject;


    // Root
public:
    Q_PROPERTY(QQuickItem *root READ root WRITE setRoot NOTIFY rootChanged)
    QQuickItem *root() const;
    void setRoot(QQuickItem *root);
signals:
    void rootChanged();
private:
    QQuickItem *m_root = nullptr;


    // Documentation items
public:
    Q_PROPERTY(QVariantList documentationItems READ documentationItemsAsVariantList NOTIFY documentationItemsChanged)

    /// Attached property for the given \c item
    Q_INVOKABLE static Documentation *documentationFor(QQuickItem *item);
    /// List of items under \c root() that are attributed with the Documentation attached type
    QVector<QQuickItem *> documentationItems() const;
    QVariantList documentationItemsAsVariantList() const;
signals:
    void documentationItemsChanged();
protected:
    static QVector<QQuickItem *> documentationItemsFor(QQuickItem *item, int depth = 0);
};

#endif // NAVIGATIONCONTROLLER_H
