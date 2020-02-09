#ifndef DOCUMENTATION_H
#define DOCUMENTATION_H

#include <QObject>
#include <QQmlEngine>
#include <QString>

/** \brief Attached property for documentation in QML
 *
 * Typical usage:
 *      Button {
 *          Documentation.brief: "Short description of this button's function"
 *      }
 */
class Documentation : public QObject
{
    Q_OBJECT

    // Construction
public:
    using QObject::QObject;


    // Brief
public:
    Q_PROPERTY(QString brief READ brief WRITE setBrief NOTIFY briefChanged)
    const QString &brief() const;
    void setBrief(const QString &brief);
signals:
    void briefChanged();
private:
    QString m_brief;


    // Attached property
public:
    static Documentation *qmlAttachedProperties(QObject *object)
    {
        return new Documentation(object);
    }
};
QML_DECLARE_TYPEINFO(Documentation, QML_HAS_ATTACHED_PROPERTIES)

#endif // DOCUMENTATION_H
