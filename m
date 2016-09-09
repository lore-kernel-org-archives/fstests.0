Received: from mx1.redhat.com ([209.132.183.28]:47896 "EHLO mx1.redhat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751441AbcIIM2e
 (ORCPT <rfc822;fstests@vger.kernel.org>); Fri, 9 Sep 2016 08:28:34 -0400
MIME-Version: 1.0
Message-ID: <20160909122831.GD12847@dhcp12-143.nay.redhat.com>
Date: Fri, 9 Sep 2016 05:28:32 -0700 (PDT)
From: Zorro Lang <zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Subject: Re: [PATCH v2] xfs/098: fix xfs_repair on newer xfsprogs
References: <20160825154052.GD20705@birch.djwong.org>
 <1472182612-10218-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160826044818.GH10350@dhcp12-143.nay.redhat.com>
 <57BFDD38.7080101@cn.fujitsu.com>
 <20160826090503.GI10350@dhcp12-143.nay.redhat.com>
 <57D28101.6000902@cn.fujitsu.com>
In-Reply-To: <57D28101.6000902@cn.fujitsu.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 09, 2016 at 05:29:37PM +0800, Xiao Yang wrote:
> =D3=DA 2016/08/26 17:05, Zorro Lang =D0=B4=B5=C0:
> >On Fri, Aug 26, 2016 at 02:10:00PM +0800, Xiao Yang wrote:
> >>On 2016/08/26 12:48, Zorro Lang wrote:
> >>>On Fri, Aug 26, 2016 at 11:36:52AM +0800, Xiao Yang wrote:
> >>>>Make sure xfs_repair can't clear the log by default when it is corr=
upted.
> >>>>xfs_repair always and only clear the log when the -L parameter is s=
pecified.
> >>>>This has updated by:
> >>>>Commit f2053bc ("xfs_repair: don't clear the log by default")
> >>>>
> >>>>Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>>>---
> >>>>  common/rc     | 4 ++--
> >>>>  tests/xfs/098 | 2 +-
> >>>>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>>diff --git a/common/rc b/common/rc
> >>>>index 3fb0600..c693a31 100644
> >>>>--- a/common/rc
> >>>>+++ b/common/rc
> >>>>@@ -1143,9 +1143,9 @@ _repair_scratch_fs()
> >>>Hi Xiao
> >>>
> >>>You should explain why you changed this function in commit log. Or
> >>>the reviewer can't understand why you change it.
> >>>
> >>>>      xfs)
> >>>>          _scratch_xfs_repair "$@" 2>&1
> >>>>  	res=3D$?
> >>>>-	if [ "$res" -eq 2 ]; then
> >>>>+	if [ "$res" -ne 0 ]; then
> >>>Hi Darrick,
> >>>
> >>>The xfs_repair manpage said:
> >>>xfs_repair run without the -n option will always return a status cod=
e of 0.
> >>>
> >>>I don't understand why you think it return 2 here? (Please check bel=
ow)
> >>>
> >>Hi Zorro
> >>
> >>I don't understand why it return 2 here too.  I want to change this
> >>function because xfs_repair
> >>without -L option return 1 when log is corrupted on newer xfsprogs-de=
v.
> >>>>  		echo "xfs_repair returns $res; replay log?"
> >>>>-		_scratch_mount
> >>>>+		_scratch_mount 2>&1
> >>>>  		res=3D$?
> >>>>  		if [ "$res" -gt 0 ]; then
> >>>>  			echo "mount returns $res; zap log?"
> >>>>diff --git a/tests/xfs/098 b/tests/xfs/098
> >>>>index d91d617..eb33bb1 100755
> >>>>--- a/tests/xfs/098
> >>>>+++ b/tests/xfs/098
> >>>>@@ -93,7 +93,7 @@ echo "+ mount image"
> >>>>  _scratch_mount 2>/dev/null&&   _fail "mount should not succeed"
> >>>>
> >>>>  echo "+ repair fs"
> >>>>-_scratch_xfs_repair>>   $seqres.full 2>&1
> >>>>+_repair_scratch_fs>>   $seqres.full
> >You should print the stderr to $seqres.full too. Because in
> >"_repair_scratch_fs", its code likes below:
> >
> >     xfs)
> >         _scratch_xfs_repair "$@" 2>&1
> >>>>This repair won't clear the corrupted log anymore.
> >         res=3D$?
> >         if [ "$res" -eq 2 ]; then
> >                 echo "xfs_repair returns $res; replay log?"
> >                 _scratch_mount
> >>>>So this mount maybe failed if it can't deal with the corrupted log.
> >>>>If it print some error messages, it'll break the golden image of xf=
s/098
> >                 res=3D$?
> >                 if [ "$res" -gt 0 ]; then
> >                         echo "mount returns $res; zap log?"
> >                         _scratch_xfs_repair -L 2>&1
> >
> >
> >>>If just call xfs_repair without any options, the _repair_scratch_fs =
won't
> >>>help to call xfs_repair -L I think.
> >>>
> >>>So I think this patch won't fix the problem.
> >>>
> >>>Feel free to correct me, if I misunderstand something:)
> >>>
> >>>Thanks,
> >>>Zorro
> >>>
> >>If xfs_repair without any option succeed to repair filesystem when
> >>log is corrupted,
> >>_repair_scratch_fs don't need  to call  xfs_repair -L.  If it failed
> >>to repair filesystem,
> >>_repair_scratch_fs needs  to call  xfs_repair -L.
> >Oh, sorry, I just tried to run ths case. The "_scratch_xfs_repair" rea=
lly return
> >non-zero when it try to repair a corrupted xfs...
> >
> >But the manpage(man xfs_repair) really said:
> >xfs_repair run without the -n option will always return a status code =
of 0.
> >
> >Maybe we should update the manpage? I'll check it later.
> >
> >Any way, there's still a problem in your patch, please see above:
> >
> >Thanks,
> >Zorro
> Hi Zorro
> Do you know why it returns 2 instead of 1 when we use xfs_repair
> without any options.
> I can't understand it, because it always return 1 on my machine.

Hi Xiao,

Please CC the mail list, there's no secret. And the most important
thing is if I said something wrong, others great developers maybe
glad to correct me:-P

I've asked DJ Wong about the return value of xfs_repair, and he
already replied:

"xfs_repair returns 2 when the log is corrupted, 1 when there's corruptio=
n left
to be fixed *or* some kind of operation error happened, and 0 if either i=
t
found nothing wrong or all the corruptions were fixed."

I'm sure that email has been sent to you too.

If you can't understand why it return 1, you can check your xfs/098.full =
file,
you'll find:

"Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
Log inconsistent (didn't find previous header)
failed to find log head
zero_log: cannot find log head/tail (xlog_find_tail=3D5)

fatal error -- ERROR: The log head and/or tail cannot be discovered. Atte=
mpt to mount the
filesystem to replay the log or use the -L option to destroy the log and
attempt a repair.
xfs_repair failed, err=3D1"

This output from below xfsprogs code:

        error =3D xlog_find_tail(log, &head_blk, &tail_blk);
        if (error) {
                do_warn(
                _("zero_log: cannot find log head/tail (xlog_find_tail=3D=
%d)\n"),
                        error);
                if (!no_modify && !zap_log)
>>> [exit from here] >>>    do_error(_(
"ERROR: The log head and/or tail cannot be discovered. Attempt to mount t=
he\n"
"filesystem to replay the log or use the -L option to destroy the log and=
\n"
"attempt a repair.\n"));
        } else {
                if (verbose) {
                        do_warn(
        _("zero_log: head block %" PRId64 " tail block %" PRId64 "\n"),
                                head_blk, tail_blk);
                }
                if (!no_modify && head_blk !=3D tail_blk) {
                        if (zap_log) {
                                do_warn(_(
"ALERT: The filesystem has valuable metadata changes in a log which is be=
ing\n"
"destroyed because the -L option was used.\n"));
                        } else {
                                do_warn(_(
"ERROR: The filesystem has valuable metadata changes in a log which needs=
 to\n"
"be replayed.  Mount the filesystem to replay the log, and unmount it bef=
ore\n"
"re-running xfs_repair.  If you are unable to mount the filesystem, then =
use\n"
"the -L option to destroy the log and attempt a repair.\n"
"Note that destroying the log may cause corruption -- please attempt a mo=
unt\n"
"of the filesystem before doing this.\n"));
                                exit(2);
                        }
                }
        }

I've marked [exit from here] for you. do_error will call exit(1). And the=
 output
message already tell you the reason about why it fail.

You can keep reading, there's a "exit(2)" at the end of above code. I can=
't find
more exit(2) from xfsprogs/repair/ . So maybe this's the only one place w=
hich
can return 2. From the information above that exit(2), you can see that
xfs_repair will return 2 when it find there're some valuable metadata cha=
nges in
a log. It think a mount operation maybe can replay this log, so it return=
 2 and
suggest the user try to mount the filesystem. If mount can't replay the l=
og, -L
is the next choice.

So I think the _repair_scratch_fs function in xfstests/common/rc doesn't =
think
about above situation. xfs_repair doesn't always return 2 if log corrupte=
d.
Only xfs_repair feel log can be replay, it'll return 2, or it'll return 1=
. So
maybe we should change "if [ $res -eq 2 ]" to "if [ $res -ne 0 ]". Or we =
need
to change xfs_repair to make it return 2:-P

For xfs/098's problem, you can change the line#96:
from
_scratch_xfs_repair >> $seqres.full 2>&1
to
_repair_scratch_fs >> $seqres.full 2>&1

And _repair_scratch_fs need to be modified as I said above. I think I sho=
uld write
a patch to describe the return value of xfs_repair(without -n). The curre=
nt
xfs_repair manpage said:
"xfs_repair run without the -n option will always return a status code of=
 0."
it's wrong.

OK, I've talked too much. If anyone feel anything wrong, please corrent m=
e:)

Thanks,
Zorro

>=20
> Thanks,
> yang
> >>Thanks
> >>Xiao Yang.
> >>>>  echo "+ mount image (2)"
> >>>>  _scratch_mount
> >>>>--=20
> >>>>1.8.3.1
> >>>>
> >>>>
> >>>>
> >>>>--
> >>>>To unsubscribe from this list: send the line "unsubscribe fstests" =
in
> >>>>the body of a message to majordomo@vger.kernel.org
> >>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>.
> >>>
> >>
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe fstests" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >.
> >
>=20
>=20
>=20
