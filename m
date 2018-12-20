Received: from mail-pg1-f195.google.com ([209.85.215.195]:37131 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeLTFiL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Dec 2018 00:38:11 -0500
MIME-Version: 1.0
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
 <20181219071834.GA14993@infradead.org> <966737066.61401666.1545272222334.JavaMail.zimbra@redhat.com>
 <CAH2r5mueD3quzrQ=pnY+w1H9T7FDK5tfmif-AoBJ66a-LVhK=A@mail.gmail.com>
 <1452958469.61405906.1545274994447.JavaMail.zimbra@redhat.com>
 <CAH2r5mufbw3S2UHEpUw0j=M5mj-CZaYcObySyRvXhConbAyGbA@mail.gmail.com> <587342593.61413183.1545283407465.JavaMail.zimbra@redhat.com>
In-Reply-To: <587342593.61413183.1545283407465.JavaMail.zimbra@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 19 Dec 2018 23:37:57 -0600
Message-ID: <CAH2r5mtXj75Cv-wb9=FsbOkw1Lx3ZrrYpJkEh4tJD2zQC-D4PA@mail.gmail.com>
Subject: Re: [PATCH v1] xfstests: filter the default EA
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiaoli Feng <xifeng@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, CIFS <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 19, 2018 at 11:23 PM Xiaoli Feng <xifeng@redhat.com> wrote:
>
> Hello,
>
> ----- Original Message -----
> > From: "Steve French" <smfrench@gmail.com>
> > To: "Xiaoli Feng" <xifeng@redhat.com>
> > Cc: "Christoph Hellwig" <hch@infradead.org>, fstests@vger.kernel.org, "Ronnie Sahlberg" <lsahlber@redhat.com>, "CIFS"
> > <linux-cifs@vger.kernel.org>
> > Sent: Thursday, December 20, 2018 11:53:09 AM
> > Subject: Re: [PATCH v1] xfstests: filter the default EA
> >
> > What server type (presumably Samba if mounting to localhost)?  What
>
> Yes, it's Samba.
<snip>
> The dialect is smb3.02.

Since cifs.ko does not know about or special case this attribute, the
next step is to figure out who is returning this attribute - Samba
server or something above the client.
Typically I approach this by doing a quick wireshark trace (or follow
the process described at
https://wiki.samba.org/index.php/LinuxCIFS_troubleshooting#Wire_Captures),
that will very quickly allow you to determine if it even came from the
server.  If it came from the server, follow the normal process for
enabling Samba logging (setting log level in smb.conf and looking at
why the xattr is being returned by examining the corresponding log
file in /var/log/samba/).   If you don't see it coming from the
server, then enabling the usual dynamic trace (trace-cmd) of the
syscall may be helpful.
Note that there are a fairly large number of xattr related trace
points (see /sys/kernel/tracing/events/syscalls).  Looking at this
does remind me that I should add dynamic trace points to cifs.ko for
smb3_get/set xattrs (for the error and success cases) although it
probably wouldn't be needed in this case - it would have allowed us to
more quickly rule out Samba returning this.

> > What does the getfattr on the local path show as the attributes?
>
> It shows nothing for local path on xfs filesystem.
>
> # touch /file
> # getfattr /file
> #
