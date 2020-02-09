#include "DocumentationController.h"

// Root

QQuickItem *DocumentationController::root() const
{
    return m_root;
}

void DocumentationController::setRoot(QQuickItem *root)
{
    if (m_root == root)
    {
        return;
    }
    m_root = root;
    emit rootChanged();
    emit documentationItemsChanged();
}


// Documentation

Documentation *DocumentationController::documentationFor(QQuickItem *item)
{
    return qobject_cast<Documentation *>(qmlAttachedPropertiesObject<Documentation>(item, false)); // don't create
}

QVector<QQuickItem *> DocumentationController::documentationItems() const
{
    return documentationItemsFor(root());
}

QVariantList DocumentationController::documentationItemsAsVariantList() const
{
    QVariantList variantList;
    for (QQuickItem *item : documentationItems())
    {
        variantList += QVariant::fromValue(item);
    }
    return variantList;
}

QVector<QQuickItem *> DocumentationController::documentationItemsFor(QQuickItem *item, int depth)
{
    if (item == nullptr)
    {
        return {};
    }
    if (!item->isVisible())
    {
        return {};
    }

    QVector<QQuickItem *> documentationItems;

    // Self
    const Documentation *documentation = documentationFor(item);
    if (documentation != nullptr)
    {
        documentationItems += item;
    }

    // Recurse only relevant children
    if (item->property("currentItem").isValid())
    {
        auto *currentItem = item->property("currentItem").value<QQuickItem *>();
        documentationItems += documentationItemsFor(currentItem, depth+1);
        return documentationItems;
    }

    // Recurse general case
    for (auto childItem : item->childItems())
    {
        documentationItems += documentationItemsFor(childItem, depth+1);
    }
    return documentationItems;
}

#include "moc_DocumentationController.cpp"
