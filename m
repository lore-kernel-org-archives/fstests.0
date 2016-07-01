Received: from mx1.redhat.com ([209.132.183.28]:39909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbcGADNR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 23:13:17 -0400
Date: Fri, 1 Jul 2016 10:55:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] geceric/362: check truncate can update file size
 correctly when truncate fails
Message-ID: <20160701025523.GN23649@eguan.usersys.redhat.com>
References: <20160623082718.GF3226@eguan.usersys.redhat.com>
 <20160630082549.27201-1-wangxg.fnst@cn.fujitsu.com>
 <20160630135237.GG23649@eguan.usersys.redhat.com>
 <5775D54C.6070001@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5775D54C.6070001@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 10:28:28AM +0800, Wang Xiaoguang wrote:
> hello,
>=20
> On 06/30/2016 09:52 PM, Eryu Guan wrote:
> > On Thu, Jun 30, 2016 at 04:25:49PM +0800, Wang Xiaoguang wrote:
> > > In btrfs, when truncate operation fails for enospc reason, file may=
 still
> > > have some disk blocks, but it will fail to update filesize accordin=
gly.
> > >=20
> > > Kernel commit c0d2f61 has fixed this bug for btrfs:
> > >      btrfs: fix disk_i_size update bug when ftruncate() fails
> > >=20
> > > Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> > > ---
> > > v2: move this test to generic test and add comments why testcase
> > > use reflink.
> > Thanks for the updated version. Did it fail for you when testing on
> > unpatched kernel? I ran the test more than 10 times on 4.6 kernel (wh=
ich
> > doesn't have the fix) and all passed, as well as RHEL7 kernel.
> >=20
> > Can you please confirm?
> I tested this case in v4.6-rc7-162-g415b35a and it failed as expected,
> but I used the newest version btrfs-progs.
> In RHEL7.2ga, its btrfs-progs version is btrfs-progs-3.19.1-1.el7.x86_6=
4,
> which is somewhat old. For small fs, it'll enable mixed mode for data a=
nd
> metadata default, so the reflink operation in this test case does not
> consume
> enough metadata, truncate operation can still succeed, then test will a=
lways
> pass. I can create a big fs to have test, but then this fs will have mo=
re
> metadata, which then need more reflink operations to consume metadata a=
nd
> increase the test time greatly.
>=20
> In mkfs.btrfs manpage, there is such description=EF=BC=9A
>      versions up to 4.2.x forced the mixed mode for devices smaller
>      than 1GiB. This has been removed in 4.3+ as it caused some
>      usability issues.

I also tested on 4.6 kernel with v4.6 btrfs-progs, it passed 10+ times
without a fail. I was testing on a 4vcpu kvm guest with 8G memory,
TEST_DEV and SCRATCH_DEV are all 15G in size, not sure if that matters.

Thanks,
Eryu
