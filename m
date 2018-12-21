Received: from mx1.redhat.com ([209.132.183.28]:40696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbeLUEBg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Dec 2018 23:01:36 -0500
Date: Thu, 20 Dec 2018 23:01:35 -0500 (EST)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <845013525.61641054.1545364895874.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5mtXj75Cv-wb9=FsbOkw1Lx3ZrrYpJkEh4tJD2zQC-D4PA@mail.gmail.com>
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com> <20181219071834.GA14993@infradead.org> <966737066.61401666.1545272222334.JavaMail.zimbra@redhat.com> <CAH2r5mueD3quzrQ=pnY+w1H9T7FDK5tfmif-AoBJ66a-LVhK=A@mail.gmail.com> <1452958469.61405906.1545274994447.JavaMail.zimbra@redhat.com> <CAH2r5mufbw3S2UHEpUw0j=M5mj-CZaYcObySyRvXhConbAyGbA@mail.gmail.com> <587342593.61413183.1545283407465.JavaMail.zimbra@redhat.com> <CAH2r5mtXj75Cv-wb9=FsbOkw1Lx3ZrrYpJkEh4tJD2zQC-D4PA@mail.gmail.com>
Subject: Re: [PATCH v1] xfstests: filter the default EA
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, CIFS <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Steve French" <smfrench@gmail.com>
> To: "Xiaoli Feng" <xifeng@redhat.com>
> Cc: "Christoph Hellwig" <hch@infradead.org>, fstests@vger.kernel.org, "Ronnie Sahlberg" <lsahlber@redhat.com>, "CIFS"
> <linux-cifs@vger.kernel.org>
> Sent: Thursday, December 20, 2018 1:37:57 PM
> Subject: Re: [PATCH v1] xfstests: filter the default EA
> 
> On Wed, Dec 19, 2018 at 11:23 PM Xiaoli Feng <xifeng@redhat.com> wrote:
> >
> > Hello,
> >
> > ----- Original Message -----
> > > From: "Steve French" <smfrench@gmail.com>
> > > To: "Xiaoli Feng" <xifeng@redhat.com>
> > > Cc: "Christoph Hellwig" <hch@infradead.org>, fstests@vger.kernel.org,
> > > "Ronnie Sahlberg" <lsahlber@redhat.com>, "CIFS"
> > > <linux-cifs@vger.kernel.org>
> > > Sent: Thursday, December 20, 2018 11:53:09 AM
> > > Subject: Re: [PATCH v1] xfstests: filter the default EA
> > >
> > > What server type (presumably Samba if mounting to localhost)?  What
> >
> > Yes, it's Samba.
> <snip>
> > The dialect is smb3.02.
> 
> Since cifs.ko does not know about or special case this attribute, the
> next step is to figure out who is returning this attribute - Samba
> server or something above the client.
> Typically I approach this by doing a quick wireshark trace (or follow
> the process described at
> https://wiki.samba.org/index.php/LinuxCIFS_troubleshooting#Wire_Captures),
> that will very quickly allow you to determine if it even came from the
> server.  If it came from the server, follow the normal process for
> enabling Samba logging (setting log level in smb.conf and looking at
> why the xattr is being returned by examining the corresponding log
> file in /var/log/samba/).   If you don't see it coming from the
> server, then enabling the usual dynamic trace (trace-cmd) of the
> syscall may be helpful.
> Note that there are a fairly large number of xattr related trace
> points (see /sys/kernel/tracing/events/syscalls).  Looking at this
> does remind me that I should add dynamic trace points to cifs.ko for
> smb3_get/set xattrs (for the error and success cases) although it
> probably wouldn't be needed in this case - it would have allowed us to
> more quickly rule out Samba returning this.

This EA information is returned from Samba server.

GetInfo Response (0x10)
        [Class: FILE_INFO (0x01)]
        [InfoLevel: SMB2_FILE_FULL_EA_INFO (0x0f)]
        StructureSize: 0x0009
            0000 0000 0000 100. = Fixed Part Length: 4
            .... .... .... ...1 = Dynamic Part: True
        Blob Offset: 0x00000048
        Blob Length: 56
        SMB2_FILE_FULL_EA_INFO
            EA: security.selinux := unconfined_u:object_r:mnt_t:s0
                Next Offset: 0
                EA Flags: 0x00
                EA Name Length: 16
                EA Data Length: 31
                EA Name: security.selinux
                EA Data: 756e636f6e66696e65645f753a6f626a6563745f723a6d6e...


> 
> > > What does the getfattr on the local path show as the attributes?
> >
> > It shows nothing for local path on xfs filesystem.
> >
> > # touch /file
> > # getfattr /file
> > #
> 
