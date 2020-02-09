#include "Documentation.h"

// Brief

const QString &Documentation::brief() const
{
    return m_brief;
}

void Documentation::setBrief(const QString &brief)
{
    if (m_brief == brief)
    {
        return;
    }
    m_brief = brief;
    emit briefChanged();
}

#include "moc_Documentation.cpp"
