Received: from synology.com ([59.124.61.242]:55280 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbcKBDwI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Nov 2016 23:52:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 02 Nov 2016 11:52:00 +0800
From: robbieko <robbieko@synology.com>
Subject: Re: [PATCH v2 4/4] xfstests: btrfs/134: add test for incremental send
 which renames a directory already being deleted
In-Reply-To: <20161101072055.GQ27776@eguan.usersys.redhat.com>
References: <1477619046-16375-1-git-send-email-robbieko@synology.com>
 <1477619046-16375-5-git-send-email-robbieko@synology.com>
 <20161101072055.GQ27776@eguan.usersys.redhat.com>
Message-ID: <5a436c110e0b823a9b6babedfe450734@synology.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu Guan,

Yes, it need apply
[PATCH] "Btrfs: incremental send, do not skip generation inconsistency=20
check for inode 256."
and test again, it will failed.

because current code there is a problem, but just will not happen.

Thansk
Robbie Ko

Eryu Guan =E6=96=BC 2016-11-01 15:20 =E5=AF=AB=E5=88=B0:
> On Fri, Oct 28, 2016 at 09:44:06AM +0800, robbieko wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>=20
>> Test that an incremental send operation dosen't work because
>> it tries to rename a directory which is already deleted.
>>=20
>> This test exercises scenarios used to fail in btrfs and are fixed by
>> the following patch for the linux kernel:
>>=20
>> "Btrfs: incremental send, add generation check for inode is waiting=20
>> for move."
>=20
> I was testing with v4.9-rc1+ kernel and btrfs-progs v4.6. Seems above
> patch is not merged in 4.9-rc1 kernel, but test passed for me, is that
> expected?
>=20
> Thanks,
> Eryu


