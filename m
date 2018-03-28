Received: from mail-pl0-f65.google.com ([209.85.160.65]:36196 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC1GTx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Mar 2018 02:19:53 -0400
Date: Wed, 28 Mar 2018 14:19:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 3/3] fstests: generic: Check the fs after each FUA
 writes
Message-ID: <20180328061945.GF30836@localhost.localdomain>
References: <20180328044023.22078-1-wqu@suse.com>
 <20180328044023.22078-3-wqu@suse.com>
 <CAOQ4uxj5ff5-AhoACxZGG+ZeHRh0Qr_=uPqyzMUv5h934dicuQ@mail.gmail.com>
 <2956631d-3843-aaf6-8d75-3a2028fea88b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2956631d-3843-aaf6-8d75-3a2028fea88b@gmx.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 28, 2018 at 01:51:44PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8828=E6=97=A5 13:04, Amir Goldstein wrote:
> > On Wed, Mar 28, 2018 at 7:40 AM, Qu Wenruo <wqu@suse.com> wrote:
> >> Basic test case which triggers fsstress with dm-log-writes, and then
> >> check the fs after each FUA writes.
> >> With needed infrastructure and special handlers for journal based fs.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> changelog:
> >> v2:
> >>   Use proper "SUSE Linux Products GmbH" instead of "SuSE"
> >>   Get rid of dm-snapshot which is pretty slow if we're creating and
> >>   deleting snapshots repeatedly.
> >>   (Maybe LVM thin provision would be much better, but current replay
> >>    solution is good so far, and no slower than dm-snapshot)
> >>   Add back run_check so that we can get the seed.
> >> ---
> >> Unfortunately, neither xfs nor ext4 survies this test for even singl=
e
> >> success, while btrfs survives.
> >> (Although not what I want, I'm just trying my luck
> >> to reproduce a serious btrfs corruption situation)
> >>
> >> Although btrfs may be the fastest fs for the test, since it has fixe=
d
> >> small amount of write in mkfs and almost nothing to replay, it still
> >> takes about 240s~300s to finish (the same level using snapshot).
> >>
> >> It would take longer time for ext4 for its large amount of write dur=
ing
> >> mkfs, if it can survive the test in the first space.
> >=20
> > Hmm, how much time would the total test would take if you don't fail
> > it on fsck? I am asking because it may be possible to improve this wi=
th
> > only a single snapshot after mkfs.
>=20
> The only fs which can pass the test right now is btrfs, so other
> estimation is mostly based on guess.
>=20
> >=20
> > Anyway, if total test run time is expected to be under 10min I wouldn=
't
> > bother with this optimization, at least not right now. IMO it is more
> > important to get the test out there to get the corruption bugs floati=
ng.
>=20
> I'd say from current status, if XFS doesn't fail, it would definitely
> finish in 10min.
> For EXT4 I'm not pretty sure.
                                                                         =
                                                                         =
                                            =20
10min might be a bit long, 5min would be good enough. I may need to
adjust the fsstress "-n" param based on test results when I got some
time, hopefully this week..

And I noticed that fsstress "-p" is based on nr_cpus, I'd like to cap it
with a max allowed number, so test won't run for too long on hosts with
hundreds of cpus. It could always be scaled with _scale_fsstress_args.

+nr_cpus=3D$("$here/src/feature" -o)
+fsstress_args=3D$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_=
cpus \
+               $FSSTRESS_AVOID)

>=20
> I'd like to  keep current test case as simple as possible right now, an=
d
> for later enhancement, I have several different ideas:

Please make new tests then :)

>=20
> 1) Reflink fs + loopback
>    Yep, use btrfs/xfs as base filesystem and create copy using reflink,
>    then use such files as loopback device.
>    The good thing is, AFAIK btrfs/xfs reflink is really fast.
>    Much much faster than dm-snapshot or even LVM thin.
>=20
>    The much much smaller block size (4K default) makes CoW overhead
>    (LVM thin is 64K, not sure about dm-snapshot though).
>=20
>    The problem is, such setup needs extra mount point and can be a
>    little hard to setup, and we're introducing another layer of fs,
>    if the fs itself has some hidden bug, it would screw up the test
>    case.
>=20
> 2) LVM thin provision
>    LVM thin provision looks much like btrfs/xfs for block level, and
>    smaller default block size (64K vs original 2M) makes CoW overhead
>    smaller.
>=20
>    I'm currently testing this method, the good thing is it's a little
>    easier to setup and we can use single mount point.
>=20
> Anyway, with proper and efficient snapshot ability implemented, I will
> definitely convert this test case, and add Flush test case.
>=20
> Thanks for your review too,
> Qu
>=20
> >=20
> > Thanks for working on this!
> > You can add
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thank you both!

Eryu
