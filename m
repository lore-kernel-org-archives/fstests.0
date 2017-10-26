Received: from mx1.redhat.com ([209.132.183.28]:39466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdJZHea (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 03:34:30 -0400
Date: Thu, 26 Oct 2017 15:34:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: Add message indicating btrfs-progs support FST
 in read-only mode
Message-ID: <20171026073428.GL3235@eguan.usersys.redhat.com>
References: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
 <20171026065218.GK3235@eguan.usersys.redhat.com>
 <516DDBE5B1D92D42BCF7A2E37F045A5D01479E2127@G08CNEXMBPEKD02.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <516DDBE5B1D92D42BCF7A2E37F045A5D01479E2127@G08CNEXMBPEKD02.g08.fujitsu.local>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Gu, Jinxiang" <gujx@cn.fujitsu.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 26, 2017 at 07:16:02AM +0000, Gu, Jinxiang wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Eryu Guan [mailto:eguan@redhat.com]
> > Sent: Thursday, October 26, 2017 2:52 PM
> > To: Gu, Jinxiang/=E9=A1=BE =E9=87=91=E9=A6=99 <gujx@cn.fujitsu.com>
> > Cc: fstests@vger.kernel.org; linux-btrfs@vger.kernel.org
> > Subject: Re: [PATCH] xfstests: Add message indicating btrfs-progs sup=
port FST in read-only mode
> >=20
> > On Thu, Oct 26, 2017 at 01:57:46PM +0800, Gu Jinxiang wrote:
> > > From: Gu JinXiang <gujx@cn.fujitsu.com>
> > >
> > > btrfs-progs now support FST in read-only mode, so when space_cache=3D=
v2
> > > enabled, this test case will fail.
> > > Add message to help user to understand this status.
> >=20
> > Sorry, I don't quite understand the new 'FST' feature. But is it a bu=
g that we want to fix when mounting with space_cache=3Dv2
> > option, or we just couldn't do btrfs-convert in this case? If it's a =
real bug, I'd say let the test fail as it is, and
> > track bug in tools like bugzilla not comments/messages in the test; i=
f it's the latter case, then just _notrun the test
> > if space_cache=3Dv2 option is specified, e.g.
> >=20
> > _exclude_scratch_mount_option "space_cache=3Dv2"
> Thank you for your suggestion.
> As an known behavior when use btrfs-convert when space_cache=3Dv2 enabl=
ed, I prefer to modify this case not to be run.
> I all send a new patch for this.

But from what Qu said in his reply, it looks like this is a real bug in
btrfs-convert, so I don't think _notrun is a good idea. I'd leave the
test as it is, because that's a bug and this test finds it.

Thanks,
Eryu
