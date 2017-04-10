Received: from mx1.redhat.com ([209.132.183.28]:39748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbdDJJZa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Apr 2017 05:25:30 -0400
Date: Mon, 10 Apr 2017 17:25:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] Code to allow cros-compilation on chromeOS
Message-ID: <20170410092528.GE22845@eguan.usersys.redhat.com>
References: <20170327113537.GR14226@eguan.usersys.redhat.com>
 <20170404173722.23696-1-gwendal@chromium.org>
 <20170406111815.GK22845@eguan.usersys.redhat.com>
 <CAMHSBOVkP9tckPZGv8nPXDrx-tb=N6-Q5eQ8kzCRc0NUsAipKQ@mail.gmail.com>
 <20170407041227.GN22845@eguan.usersys.redhat.com>
 <CAMHSBOVYcqdByoCvtow5agrBE+f39M6zTsg1CHGift2d13tgcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHSBOVYcqdByoCvtow5agrBE+f39M6zTsg1CHGift2d13tgcg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 07, 2017 at 02:41:59PM -0700, Gwendal Grignou wrote:
> Reading  stack overflow further, the fact AC_PACKAGE_GLOBALS and
> AC_PACKAGE_UTILITIES are not defined are just the consequence of the
> error.
> When all work fine, the autoconfigued ./aclocal.m4 should contains
> several m4_include and in particular
> m4_include([m4/package_globals.m4])" that will load the definitions
> for these macros.
> I am shooting in the dark, how ./aclocal.m4 compares between RH7.0 and RH6.9?

RHEL6.9:
https://paste.fedoraproject.org/paste/EUo-NKzoZPwbIIhn1bjoJF5M1UNdIGYhyRLivL9gydE=

RHEL7.3:
https://paste.fedoraproject.org/paste/SEhryYO0GXT8VIA0-24q8V5M1UNdIGYhyRLivL9gydE=

> What are the revisions of automake, autoconf, m4 andlibtoolize.

[root@eguan-rhel6 xfstests]# rpm -q automake autoconf m4 libtool
automake-1.11.1-4.el6.noarch
autoconf-2.63-5.1.el6.noarch
m4-1.4.13-5.el6.x86_64
libtool-2.2.6-15.5.el6.x86_64

[root@dhcp-66-87-213 xfstests]# rpm -q automake autoconf m4 libtool
automake-1.13.4-3.el7.noarch
autoconf-2.69-11.el7.noarch
m4-1.4.16-10.el7.x86_64
libtool-2.4.2-21.el7_2.x86_64

> Does autoreconf -fi help?

No, autoreconf -fi has the same issue.

> 
> Thanks for your help,
> Gwendal.

Thank you!

Eryu
