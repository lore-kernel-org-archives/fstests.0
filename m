Received: from mail-pg1-f193.google.com ([209.85.215.193]:46869 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHDJY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 22:09:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id a22so304081pgg.13
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2019 19:09:23 -0800 (PST)
Date: Fri, 8 Mar 2019 11:09:18 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] Add new xattr test 532
Message-ID: <20190308030918.GN2824@desktop>
References: <20190305043613.11752-1-lsahlber@redhat.com>
 <20190306125234.GJ2824@desktop>
 <22121819.6359026.1551926783232.JavaMail.zimbra@redhat.com>
 <20190308024253.GM2824@desktop>
 <CAN05THQLazQzr_+-WXh2OAPwGpHFEwiNYaEL9xJtEe0GPTk3Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN05THQLazQzr_+-WXh2OAPwGpHFEwiNYaEL9xJtEe0GPTk3Tw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 08, 2019 at 01:01:11PM +1000, ronnie sahlberg wrote:
> On Fri, Mar 8, 2019 at 12:43 PM Eryu Guan <guaneryu@gmail.com> wrote:
> >
> > On Wed, Mar 06, 2019 at 09:46:23PM -0500, Ronnie Sahlberg wrote:
> > >
> > >
> > >
> > >
> > > ----- Original Message -----
> > > > From: "Eryu Guan" <guaneryu@gmail.com>
> > > > To: "Ronnie Sahlberg" <lsahlber@redhat.com>
> > > > Cc: "fstests" <fstests@vger.kernel.org>
> > > > Sent: Wednesday, 6 March, 2019 10:52:34 PM
> > > > Subject: Re: [PATCH] Add new xattr test 532
> > > >
> > > > On Tue, Mar 05, 2019 at 02:36:13PM +1000, Ronnie Sahlberg wrote:
> > > > > This test is cloned from 097 but has had all the tests for trusted.*
> > > > > removed.
> > > > > This makes it possible to use this test on filesystems that can only
> > > > > provide user.* xattrs such as CIFS.
> > > > >
> > > > > Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > > >
> > > > Sorry I missed your last patch of this clone..
> > >
> > > No worries.  I will resend it later once I address Daves concerns.
> > >
> > > >
> > > > Do I need to do special setup for CIFS to support xattr? Currently I got
> > > > test _notrun because attrs are not supported by CIFS. I was mounting a
> > > > local samba server with
> > > >
> > > > -o vers=3.0 -o username=user,password=passwd,sfu -o
> > > > context=system_u:object_r:root_t:s0 //localhost/scratch /mnt/scratch
> > >
> > > You don't need the 'sfu' mount option but you likely need to make sure you have the proper vfs modules loaded for samba:
> > > I use this on my share :
> > >
> > > [Share]
> > >       path = /Share
> > >       read only = no
> > >       guest ok = no
> > >       vfs objects = acl_xattr, streams_xattr aio_pthread
> > >       ea support = yes
> > >       aio read size = 16384
> > >       aio write size = 16384
> > >
> > > I think the only important one is ea support = yes (the xattrs are stored as EAs)
> >
> > I got xattr working on CIFS now, thanks!
> >
> > >
> > >
> > >
> > > >
> > > > Kernel is 5.0.0-rc7.
> > > >
> > > > But instead of cloning all the user.* xattr tests, I think it's better
> > > > to split generic/097, leave all trusted.* xattr tests there and move all
> > > > user.* xattr tests to this new test. So we don't have to maintain two
> > > > copys of the same user.* xattr tests.
> >
> > But it seems you missed above comments when sending new version of the
> > patch :)
> 
> Oh I missed that. Should just be a matter of deleting these tests from 097?

Yes, I think that should be enough.

> Do you want me to re-send the patch?

Yes please. Thanks a lot!

Eryu
