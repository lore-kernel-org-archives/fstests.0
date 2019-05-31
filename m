Received: from mx2.suse.de ([195.135.220.15]:47070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaKso (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 31 May 2019 06:48:44 -0400
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
Subject: Re: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517: notrun on NFS due to unaligned dedupe in test
In-Reply-To: <20190530155851.GB5383@magnolia>
References: <20190530094147.14512-1-xzhou@redhat.com> <20190530152606.GA5383@magnolia> <20190530155851.GB5383@magnolia>
Date: Fri, 31 May 2019 12:48:40 +0200
Message-ID: <87woi6yk53.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>, sfrench@samba.org, anna.schumaker@netapp.com, trond.myklebust@hammerspace.com, fengxiaoli0714@gmail.com
Cc: fstests@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

"Darrick J. Wong" <darrick.wong@oracle.com> writes:
> (Not sure about cifs, since I don't have a Windows Server handy)
>
> I'm not an expert in CIFS or NFS, so I'm asking: do either support
> dedupe or is this a kernel bug?

AFAIK, the SMB protocol has 2 ioctl to do server side copies:
- FSCTL_SRV_COPYCHUNK [1] generic
- FSCTL_DUPLICATE_EXTENTS_TO_FILE [2], only supported on windows "new" Co=
W
  filesystem ReFS

Cheers,

1:https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/cd=
0162e4-7650-4293-8a2a-d696923203ef
2:https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/4f=
08d2f8-bd17-4181-9cec-54c4f6a1b439
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 21284 (AG N=C3=BC=
rnberg)
