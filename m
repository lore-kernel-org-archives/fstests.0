Received: from mail-pf1-f195.google.com ([209.85.210.195]:43229 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeLTDxW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Dec 2018 22:53:22 -0500
MIME-Version: 1.0
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
 <20181219071834.GA14993@infradead.org> <966737066.61401666.1545272222334.JavaMail.zimbra@redhat.com>
 <CAH2r5mueD3quzrQ=pnY+w1H9T7FDK5tfmif-AoBJ66a-LVhK=A@mail.gmail.com> <1452958469.61405906.1545274994447.JavaMail.zimbra@redhat.com>
In-Reply-To: <1452958469.61405906.1545274994447.JavaMail.zimbra@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 19 Dec 2018 21:53:09 -0600
Message-ID: <CAH2r5mufbw3S2UHEpUw0j=M5mj-CZaYcObySyRvXhConbAyGbA@mail.gmail.com>
Subject: Re: [PATCH v1] xfstests: filter the default EA
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiaoli Feng <xifeng@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, CIFS <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

What server type (presumably Samba if mounting to localhost)?  What
dialect (if RHEL since it is older it would default to cifs with posix
extensions, if kernel from last few years would default to smb3.02
dialect)?

What does the getfattr on the local path show as the attributes?

On Wed, Dec 19, 2018 at 9:03 PM Xiaoli Feng <xifeng@redhat.com> wrote:
>
> Hi Steve,
>
> ----- Original Message -----
> > From: "Steve French" <smfrench@gmail.com>
> > To: "Xiaoli Feng" <xifeng@redhat.com>
> > Cc: "Christoph Hellwig" <hch@infradead.org>, fstests@vger.kernel.org, "Ronnie Sahlberg" <lsahlber@redhat.com>,
> > "sprabhu" <sprabhu@redhat.co>, "CIFS" <linux-cifs@vger.kernel.org>
> > Sent: Thursday, December 20, 2018 10:24:26 AM
> > Subject: Re: [PATCH v1] xfstests: filter the default EA
> >
> > On Wed, Dec 19, 2018 at 8:17 PM Xiaoli Feng <xifeng@redhat.com> wrote:
> > >
> > > Hi Christoph,
> > >
> > > ----- Original Message -----
> > > > From: "Christoph Hellwig" <hch@infradead.org>
> > > > To: "XiaoLi Feng" <xifeng@redhat.com>
> > > > Cc: fstests@vger.kernel.org
> > > > Sent: Wednesday, December 19, 2018 3:18:34 PM
> > > > Subject: Re: [PATCH v1] xfstests: filter the default EA
> > > >
> > > > On Wed, Dec 19, 2018 at 11:44:28AM +0800, XiaoLi Feng wrote:
> > > > > From: xiaoli feng <xifeng@redhat.com>
> > > > >
> > > > > For some filesystems, such as CIFS, the file or directory has the
> > > > > default extend attribute. It makes these tests generic/020
> > > > > generic/337 generic/377 failed. Now add this patch to filter the
> > > > > default EA.
> > > >
> > > > What is "the default EA"?  This sounds like a CIFS bug to me.
> > >
> > > the default EA means the new file or directory has extended attributes.
> > >
> > > # touch cifs/file
> > > # getfattr cifs/file
> > > # file: cifs/file
> > > user.security.selinux
> >
> > user.security.selinux is not a cifs EA.  This "default EA" is not
> > handled/returned by CIFS.
> >
> > cifs.ko can save/return new EAs set by the user and even return a
> > couple pseudo-EAs (cifs.dosattrib for example) if that EA is queried
> > explicitly in order to return metadata (important flags needed for
> > backup etc.) - but this "user.security.selinux" "default EA" is not
> > returned by the cifs.ko code.
>
> # getfattr ~/cifs
> # mount //localhost/cifs ~/cifs -o user=root,password=redhat
> # getfattr ~/cifs
> getfattr: Removing leading '/' from absolute path names
> # file: root/cifs
> user.security.selinux
>
> After mount the cifs share, the mountpoint ~/cifs already has "
> user.security.selinux" extended attributes. I don't know who add it.
>
>
> >
> >
> > --
> > Thanks,
> >
> > Steve
> >



-- 
Thanks,

Steve
