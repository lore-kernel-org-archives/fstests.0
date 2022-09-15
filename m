Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F0ECAAA1
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Sep 2022 05:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIOF1u (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOF1t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Sep 2022 01:27:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702285FA3
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 22:27:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s18so11312858plr.4
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LYYS2Vhs09bLN2CtlGi1A8sRv4ZQrRImOlVdtSn4bpM=;
        b=BqMbV9BtNi12kwNhIlNeA6vCXpA17JrSbOmt3DbTiNOSAjLKSQIF+Cp4159w42YHBF
         6CX7Ij2wi25kw9IlRwhbimrrc+msoFC6J/m12cFAe7KvPHasG9IKIae8cFurm5q+XUns
         fBaJEDjFpovSS3OseYfhd0Gle8iQIoYnbaONfaYDzXzaS8e+/vQWnwV7wrhF2jcl6eDL
         3jwLOhLP03gEb+4xc2zi90VyagSDGfu1cs4CJk2VJGOnQjBL48mJ6ZF4cfElFi8/nJ+R
         3KsswCDcffCZMpDSQru9Bf2kXZyXSGFCKnZfDQsG7f3dlrZoc2DmalsCSbHJfOggZrU8
         FsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LYYS2Vhs09bLN2CtlGi1A8sRv4ZQrRImOlVdtSn4bpM=;
        b=7fJ6aE0MY7sjQMir2nf6GhfIGEaILvcGo9erO0I32Uq+PJciUvv2C2xGhsN7v14zcP
         OJ0HAkJxSUydQGr4Ob9gdIyLB2AoEAVlSgSd01tWs6oZOz6pB0Z5Fypm0IPQm7vbjPO/
         m4Dhps+3lGrSZRFsiLwbyegdShvs3M/QS6q+j2aj7pkt4s8CKKoJri8v4S1u8c6a61jm
         7Le1jUSgulEqQh7EzTBTtqJnTz8DdxKmuTPW9c2jj1R5HIh1vUplikNUChmooZxA2ZmB
         CFmzYN5LkaU/vqKo+Rmn5WGyj0FbnBQU5TnGZguHVu16tt+xKA+R0QvC5YMfZefjRrr0
         HWPQ==
X-Gm-Message-State: ACrzQf3jBjlugO8yNIHwM02laK6zgtH3GCQamwM15oZVDEYRXAHuq/ef
        W0OQIV5ndIDxU5dme2lqyT3FwcecdK4qR1amH1uV/YqG4c4=
X-Google-Smtp-Source: AMsMyM59V3ANWNL1o879L5qfn7gnOV/cv8viS6l+2gdD1pfELszImQIYNiFMRaBWItYm1NGl4C/BYzYtfxNBFNhgYK4=
X-Received: by 2002:a17:903:244e:b0:178:4f50:1ca0 with SMTP id
 l14-20020a170903244e00b001784f501ca0mr2648422pls.104.1663219665081; Wed, 14
 Sep 2022 22:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220914090610.1994485-1-jencce.kernel@gmail.com> <20220914151519.4dfvfjumwos7ikrq@zlang-mailbox>
In-Reply-To: <20220914151519.4dfvfjumwos7ikrq@zlang-mailbox>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 15 Sep 2022 13:27:33 +0800
Message-ID: <CADJHv_usi1xQY5SmLiTvuUJqpXQb5vZV1WeXsFOs_v6x8hu6fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] egrep, fgrep: deprecated
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Aha, I missed that. Your patch looks fine and let's go with it.

Thanks~

On Wed, Sep 14, 2022 at 11:15 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Sep 14, 2022 at 05:06:09PM +0800, Murphy Zhou wrote:
> > Since this grep commit:
> >       commit a9515624709865d480e3142fd959bccd1c9372d1
> >       Author: Paul Eggert <eggert@cs.ucla.edu>
> >       Date:   Sun Aug 15 10:52:13 2021 -0700
> >
> >           egrep, fgrep: now obsolete
> >
> > egrep will trigger a warning like:
> >       +egrep: warning: egrep is obsolescent; using grep -E
> >
> > This will break many gold output.
> >
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
>
> I've sent a patch for this issue, and it's been reviewed:
> https://lore.kernel.org/fstests/20220913125258.exj4iszolctiuxv2@zlang-mai=
lbox/T/#t
>
> Welcome more review points, if you still find more problems after merging=
 it.
>
> Thanks,
> Zorro
>
> >  check              |  2 +-
> >  common/btrfs       |  4 ++--
> >  common/dmlogwrites |  2 +-
> >  common/dump        |  4 ++--
> >  common/encrypt     |  4 ++--
> >  common/filter      |  2 +-
> >  common/fuzzy       |  6 +++---
> >  common/populate    |  2 +-
> >  common/quota       |  8 ++++----
> >  common/rc          | 36 ++++++++++++++++++------------------
> >  common/repair      |  2 +-
> >  common/xfs         | 12 ++++++------
> >  tests/btrfs/011    |  2 +-
> >  tests/btrfs/100    |  2 +-
> >  tests/btrfs/101    |  2 +-
> >  tests/btrfs/187    |  2 +-
> >  tests/btrfs/252    |  2 +-
> >  tests/ext4/006     |  2 +-
> >  tests/generic/164  |  2 +-
> >  tests/generic/165  |  2 +-
> >  tests/generic/454  |  2 +-
> >  tests/generic/670  |  2 +-
> >  tests/xfs/008      |  2 +-
> >  tests/xfs/012      |  2 +-
> >  tests/xfs/033      |  2 +-
> >  tests/xfs/064      |  4 ++--
> >  tests/xfs/065      |  2 +-
> >  tests/xfs/083      |  2 +-
> >  tests/xfs/122      |  4 ++--
> >  tests/xfs/138      |  2 +-
> >  tests/xfs/185      |  2 +-
> >  tests/xfs/186      |  4 ++--
> >  tests/xfs/293      |  2 +-
> >  tests/xfs/330      |  2 +-
> >  tests/xfs/422      |  2 +-
> >  tests/xfs/499      |  2 +-
> >  tests/xfs/505      |  2 +-
> >  tests/xfs/514      |  2 +-
> >  tests/xfs/515      |  2 +-
> >  tests/xfs/517      |  2 +-
> >  tests/xfs/520      |  2 +-
> >  tests/xfs/530      |  2 +-
> >  tests/xfs/539      |  2 +-
> >  43 files changed, 76 insertions(+), 76 deletions(-)
> >
> > diff --git a/check b/check
> > index 0b2f10ed..1a43c116 100755
> > --- a/check
> > +++ b/check
> > @@ -389,7 +389,7 @@ if $have_test_arg; then
> >                               test_name=3D`basename $t`
> >                               group_file=3D$SRC_DIR/$test_dir/group.lis=
t
> >
> > -                             if egrep -q "^$test_name" $group_file; th=
en
> > +                             if grep -Eq "^$test_name" $group_file; th=
en
> >                                       # in group file ... OK
> >                                       echo $SRC_DIR/$test_dir/$test_nam=
e \
> >                                               >>$tmp.arglist
> > diff --git a/common/btrfs b/common/btrfs
> > index bd2639bf..d27d3384 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -9,7 +9,7 @@ _btrfs_get_subvolid()
> >       mnt=3D$1
> >       name=3D$2
> >
> > -     $BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | $AWK_PROG '{ =
print $2 }'
> > +     $BTRFS_UTIL_PROG sub list $mnt | grep -E "\s$name$" | $AWK_PROG '=
{ print $2 }'
> >  }
> >
> >  # _require_btrfs_command <command> [<subcommand>|<option>]
> > @@ -183,7 +183,7 @@ _check_btrfs_filesystem()
> >
> >  _require_btrfs_dev_del_by_devid()
> >  {
> > -     $BTRFS_UTIL_PROG device delete --help | egrep devid > /dev/null 2=
>&1
> > +     $BTRFS_UTIL_PROG device delete --help | grep -E devid > /dev/null=
 2>&1
> >       [ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old "\
> >                       "(must support 'btrfs device delete <devid> /<mnt=
>')"
> >  }
> > diff --git a/common/dmlogwrites b/common/dmlogwrites
> > index 66c57e2b..9fa1c977 100644
> > --- a/common/dmlogwrites
> > +++ b/common/dmlogwrites
> > @@ -51,7 +51,7 @@ _require_log_writes_dax_mountopt()
> >       # Check options to be sure.
> >       # XFS ignores dax option(or changes it to dax=3Dnever)
> >       # and goes on if dev underneath does not support dax.
> > -     _fs_options $LOGWRITES_DMDEV | egrep -q "dax(=3Dalways|,|$)"
> > +     _fs_options $LOGWRITES_DMDEV | grep -Eq "dax(=3Dalways|,|$)"
> >       ret=3D$?
> >       _log_writes_cleanup
> >       if [ $ret -ne 0 ]; then
> > diff --git a/common/dump b/common/dump
> > index 0dcc9655..8e0446d9 100644
> > --- a/common/dump
> > +++ b/common/dump
> > @@ -128,7 +128,7 @@ _check_onl()
> >      fi
> >
> >
> > -    if egrep -i 'onl|ready' $tmp.status | grep -iv 'not ready' >/dev/n=
ull; then
> > +    if grep -Ei 'onl|ready' $tmp.status | grep -iv 'not ready' >/dev/n=
ull; then
> >       :
> >      else
> >       echo "ERROR: $dumptape is not online"
> > @@ -145,7 +145,7 @@ _wait_tape()
> >      i=3D0
> >      while [ $i -lt 20 ]; do
> >          echo "Checking status..." >>$seqres.full
> > -     if _mt status 2>&1 | tee -a $seqres.full | egrep -i "onl|ready" >=
/dev/null; then
> > +     if _mt status 2>&1 | tee -a $seqres.full | grep -Ei "onl|ready" >=
/dev/null; then
> >           break;
> >       else
> >           sleep 1
> > diff --git a/common/encrypt b/common/encrypt
> > index 8f3c46f6..5e3c6c4b 100644
> > --- a/common/encrypt
> > +++ b/common/encrypt
> > @@ -49,7 +49,7 @@ _require_scratch_encryption()
> >       # some older kernels and is ext4-specific anyway.)
> >       mkdir $SCRATCH_MNT/tmpdir
> >       if _set_encpolicy $SCRATCH_MNT/tmpdir 2>&1 >>$seqres.full | \
> > -             egrep -q 'Inappropriate ioctl for device|Operation not su=
pported'
> > +             grep -Eq 'Inappropriate ioctl for device|Operation not su=
pported'
> >       then
> >               _notrun "kernel does not support $FSTYP encryption"
> >       fi
> > @@ -125,7 +125,7 @@ _require_encryption_policy_support()
> >               local keyspec=3D$(_generate_session_encryption_key)
> >       fi
> >       if _set_encpolicy $dir $keyspec $set_encpolicy_args \
> > -             2>&1 >>$seqres.full | egrep -q 'Invalid argument'; then
> > +             2>&1 >>$seqres.full | grep -Eq 'Invalid argument'; then
> >               _notrun "kernel does not support encryption policy: '$set=
_encpolicy_args'"
> >       fi
> >       # fscrypt allows setting policies with modes it knows about, even
> > diff --git a/common/filter b/common/filter
> > index 28dea646..6433a30e 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -347,7 +347,7 @@ _filter_size_to_bytes()
> >  # verbose output
> >  _filter_fstrim()
> >  {
> > -     egrep -o "[0-9]+ bytes" | $AWK_PROG '{print $1}'
> > +     grep -Eo "[0-9]+ bytes" | $AWK_PROG '{print $1}'
> >  }
> >
> >  # Remove the ending dot appended to mount error message, util-linux 2.=
30
> > diff --git a/common/fuzzy b/common/fuzzy
> > index 809dee54..b4fda6f5 100644
> > --- a/common/fuzzy
> > +++ b/common/fuzzy
> > @@ -91,11 +91,11 @@ __filter_xfs_db_print_fields() {
> >               else
> >                       echo "${fuzzkey}"
> >               fi
> > -     done | egrep "${filter}"
> > +     done | grep -E "${filter}"
> >  }
> >
> >  # Navigate to some part of the filesystem and print the field info.
> > -# The first argument is an egrep filter for the fields
> > +# The first argument is an grep filter for the fields
> >  # The rest of the arguments are xfs_db commands to locate the metadata=
.
> >  _scratch_xfs_list_metadata_fields() {
> >       filter=3D"$1"
> > @@ -289,7 +289,7 @@ _scratch_xfs_list_fuzz_verbs() {
> >  }
> >
> >  # Fuzz some of the fields of some piece of metadata
> > -# The first argument is an egrep filter for the field names
> > +# The first argument is an grep filter for the field names
> >  # The second argument is the repair mode (online, offline, both)
> >  # The rest of the arguments are xfs_db commands to locate the metadata=
.
> >  #
> > diff --git a/common/populate b/common/populate
> > index 867776cd..9739ac99 100644
> > --- a/common/populate
> > +++ b/common/populate
> > @@ -132,7 +132,7 @@ _populate_xfs_qmount_option()
> >       # Inject our quota mount options
> >       if echo "${MOUNT_OPTIONS}" | grep -q "${quota}"; then
> >               return
> > -     elif echo "${MOUNT_OPTIONS}" | egrep -q '(quota|noenforce)'; then
> > +     elif echo "${MOUNT_OPTIONS}" | grep -Eq '(quota|noenforce)'; then
> >               _qmount_option "${quota}"
> >       else
> >               export MOUNT_OPTIONS=3D"$MOUNT_OPTIONS -o ${quota}"
> > diff --git a/common/quota b/common/quota
> > index 3a758e0f..22be3c69 100644
> > --- a/common/quota
> > +++ b/common/quota
> > @@ -141,7 +141,7 @@ _require_nobody()
> >      _cat_passwd | grep -q '^nobody'
> >      [ $? -ne 0 ] && _notrun "password file does not contain user nobod=
y."
> >
> > -    _cat_group | egrep -q '^no(body|group)'
> > +    _cat_group | grep -Eq '^no(body|group)'
> >      [ $? -ne 0 ] && _notrun "group file does not contain nobody/nogrou=
p."
> >  }
> >
> > @@ -192,7 +192,7 @@ _choose_uid()
> >
> >  _choose_gid()
> >  {
> > -    _cat_group | egrep '^no(body|group)' | perl -ne '@a =3D split(/:/)=
; END { printf "id=3D%d name=3D%s\n", $a[2],$a[0] }'
> > +    _cat_group | grep -E '^no(body|group)' | perl -ne '@a =3D split(/:=
/); END { printf "id=3D%d name=3D%s\n", $a[2],$a[0] }'
> >  }
> >
> >  _choose_prid()
> > @@ -323,12 +323,12 @@ _check_quota_usage()
> >
> >  # Report the block usage of root, $qa_user, and nobody
> >  _report_quota_blocks() {
> > -     repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $=
3, $4, $5}' | sort -r
> > +     repquota $1 | grep -E "^($qa_user|root|nobody)" | awk '{print $1,=
 $3, $4, $5}' | sort -r
> >  }
> >
> >  # Report the inode usage of root, $qa_user, and nobody
> >  _report_quota_inodes() {
> > -     repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $=
6, $7, $8}' | sort -r
> > +     repquota $1 | grep -E "^($qa_user|root|nobody)" | awk '{print $1,=
 $6, $7, $8}' | sort -r
> >  }
> >
> >  # Determine which type of quota we're using
> > diff --git a/common/rc b/common/rc
> > index 197c9415..da2e7279 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -113,7 +113,7 @@ _get_hugepagesize()
> >  {
> >       local hugepgsz=3D$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
> >       # Call _notrun if $hugepgsz is not a number
> > -     echo "$hugepgsz" | egrep -q ^[0-9]+$ || \
> > +     echo "$hugepgsz" | grep -E -q ^[0-9]+$ || \
> >               _notrun "Cannot get the value of Hugepagesize"
> >       echo $((hugepgsz * 1024))
> >  }
> > @@ -1080,7 +1080,7 @@ _scratch_mkfs_sized()
> >       case $FSTYP in
> >       xfs)
> >               # don't override MKFS_OPTIONS that set a block size.
> > -             echo $MKFS_OPTIONS |egrep -q "b?size=3D"
> > +             echo $MKFS_OPTIONS |grep -E -q "b?size=3D"
> >               if [ $? -eq 0 ]; then
> >                       _scratch_mkfs_xfs -d size=3D$fssize $rt_ops
> >               else
> > @@ -1165,13 +1165,13 @@ _scratch_mkfs_geom()
> >
> >      case $FSTYP in
> >      xfs)
> > -     if echo "$MKFS_OPTIONS" | egrep -q "b?size=3D"; then
> > +     if echo "$MKFS_OPTIONS" | grep -E -q "b?size=3D"; then
> >               MKFS_OPTIONS=3D$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=
=3D)[0-9]+k?/\1$blocksize/")
> >       else
> >               MKFS_OPTIONS+=3D" -b size=3D$blocksize"
> >       fi
> >
> > -     if echo "$MKFS_OPTIONS" | egrep -q "(su|sunit|sw|swidth)=3D"; the=
n
> > +     if echo "$MKFS_OPTIONS" | grep -E -q "(su|sunit|sw|swidth)=3D"; t=
hen
> >               MKFS_OPTIONS=3D$(echo "$MKFS_OPTIONS" | sed -r \
> >                       -e "s/(su|sunit)=3D[0-9kmg]+/su=3D$sunit_bytes/" =
\
> >                       -e "s/(sw|swidth)=3D[0-9kmg]+/sw=3D$swidth_mult/"=
)
> > @@ -1673,7 +1673,7 @@ _require_scratch_nocheck()
> >  {
> >      case "$FSTYP" in
> >       glusterfs)
> > -             echo $SCRATCH_DEV | egrep -q ":/?" > /dev/null 2>&1
> > +             echo $SCRATCH_DEV | grep -E -q ":/?" > /dev/null 2>&1
> >               if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
> >                       _notrun "this test requires a valid \$SCRATCH_DEV=
"
> >               fi
> > @@ -1873,7 +1873,7 @@ _require_test()
> >  {
> >      case "$FSTYP" in
> >       glusterfs)
> > -             echo $TEST_DEV | egrep -q ":/?" > /dev/null 2>&1
> > +             echo $TEST_DEV | grep -E -q ":/?" > /dev/null 2>&1
> >               if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
> >                       _notrun "this test requires a valid \$TEST_DEV"
> >               fi
> > @@ -2140,7 +2140,7 @@ __scratch_uses_fsdax()
> >  {
> >       local ops=3D$(_normalize_mount_options "$MOUNT_OPTIONS")
> >
> > -     echo $ops | egrep -qw "dax(=3Dalways| |$)" && return 0
> > +     echo $ops | grep -E -qw "dax(=3Dalways| |$)" && return 0
> >       return 1
> >  }
> >
> > @@ -2601,7 +2601,7 @@ _require_xfs_io_command()
> >               # Test xfs_io chattr support AND
> >               # filesystem FS_IOC_FSSETXATTR support
> >               # 'tPnE' flags are only valid for a directory so check th=
em on a directory.
> > -             if echo "$param" | egrep -q 't|P|n|E'; then
> > +             if echo "$param" | grep -E -q 't|P|n|E'; then
> >                       testio=3D`$XFS_IO_PROG -F -c "chattr +$param" $te=
stdir 2>&1`
> >                       attr_info=3D`$XFS_IO_PROG -F -r -c "lsattr" $test=
dir | awk '{print $1}'`
> >                       $XFS_IO_PROG -F -r -c "chattr -$param" $testdir 2=
>&1
> > @@ -2659,7 +2659,7 @@ _require_xfs_io_command()
> >       "-T")
> >               # Check O_TMPFILE support in xfs_io, kernel and fs
> >               testio=3D`$XFS_IO_PROG -T -c quit $TEST_DIR 2>&1`
> > -             echo $testio | egrep -q "invalid option|Is a directory" &=
& \
> > +             echo $testio | grep -E -q "invalid option|Is a directory"=
 && \
> >                       _notrun "xfs_io $command support is missing"
> >               echo $testio | grep -q "Operation not supported" && \
> >                       _notrun "O_TMPFILE is not supported"
> > @@ -3217,7 +3217,7 @@ _check_generic_filesystem()
> >  # Filter the knowen errors the UDF Verifier reports.
> >  _udf_test_known_error_filter()
> >  {
> > -     egrep -v "PVD  60  Error: Interchange Level: 1, Maximum Interchan=
ge Level: 0|FSD  28  Error: Interchange Level: 1, Maximum Interchange Level=
: 1,|PVD  72  Warning: Volume Set Identifier: \"\*IRIX UDF\",|Warning: [0-9=
]+ unused blocks NOT marked as unallocated."
> > +     grep -E -v "PVD  60  Error: Interchange Level: 1, Maximum Interch=
ange Level: 0|FSD  28  Error: Interchange Level: 1, Maximum Interchange Lev=
el: 1,|PVD  72  Warning: Volume Set Identifier: \"\*IRIX UDF\",|Warning: [0=
-9]+ unused blocks NOT marked as unallocated."
> >
> >  }
> >
> > @@ -3249,9 +3249,9 @@ _check_udf_filesystem()
> >
> >      rm -f $seqres.checkfs
> >      sleep 1 # Due to a problem with time stamps in udf_test
> > -    $here/src/udf_test $opt_arg $device | tee $seqres.checkfs | egrep =
"Error|Warning" | \
> > +    $here/src/udf_test $opt_arg $device | tee $seqres.checkfs | grep -=
E "Error|Warning" | \
> >       _udf_test_known_error_filter | \
> > -     egrep -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warni=
ng count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
> > +     grep -E -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|War=
ning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
> >          echo "Warning UDF Verifier reported errors see $seqres.checkfs=
." && return 1
> >      return 0
> >  }
> > @@ -3782,7 +3782,7 @@ _check_scratch_dax_mountopt()
> >
> >       _try_scratch_mount "-o $option" > /dev/null 2>&1 || return 1
> >
> > -     if _fs_options $SCRATCH_DEV | egrep -q "dax(=3Dalways|,|$)"; then
> > +     if _fs_options $SCRATCH_DEV | grep -E -q "dax(=3Dalways|,|$)"; th=
en
> >               _scratch_unmount
> >               return 0
> >       else
> > @@ -4048,9 +4048,9 @@ _exclude_mount_option()
> >       shift
> >       while [ $# -gt 0 ]; do
> >               local pattern=3D$1
> > -             echo "$pattern" | egrep -q "dax(=3Dalways|$)" && \
> > +             echo "$pattern" | grep -E -q "dax(=3Dalways|$)" && \
> >                       pattern=3D"dax(=3Dalways| |$)"
> > -             if echo $mnt_opts | egrep -q "$pattern"; then
> > +             if echo $mnt_opts | grep -E -q "$pattern"; then
> >                       _notrun "mount option \"$1\" not allowed in this =
test"
> >               fi
> >               shift
> > @@ -4329,7 +4329,7 @@ _dmesg_since_test_start()
> >  # _dmesg_since_test_start.
> >  _check_dmesg_for()
> >  {
> > -     _dmesg_since_test_start | egrep -q "$1"
> > +     _dmesg_since_test_start | grep -E -q "$1"
> >  }
> >
> >  # Default filter for dmesg scanning.
> > @@ -4338,7 +4338,7 @@ _check_dmesg_for()
> >  # lockdep.
> >  _check_dmesg_filter()
> >  {
> > -     egrep -v -e "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" \
> > +     grep -E -v -e "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" \
> >               -e "BUG: MAX_STACK_TRACE_ENTRIES too low"
> >  }
> >
> > @@ -4356,7 +4356,7 @@ _check_dmesg()
> >       local filter=3D${1:-_check_dmesg_filter}
> >
> >       _dmesg_since_test_start | $filter >$seqres.dmesg
> > -     egrep -q -e "kernel BUG at" \
> > +     grep -E -q -e "kernel BUG at" \
> >            -e "WARNING:" \
> >            -e "\bBUG:" \
> >            -e "Oops:" \
> > diff --git a/common/repair b/common/repair
> > index 463ef9db..8945d002 100644
> > --- a/common/repair
> > +++ b/common/repair
> > @@ -105,7 +105,7 @@ _filter_repair_lostblocks() {
> >
> >  _filter_dd()
> >  {
> > -     fgrep -v records        # lose records in/out lines
> > +     grep -F -v records      # lose records in/out lines
> >  }
> >
> >  # do some controlled corrupting & ensure repair recovers us
> > diff --git a/common/xfs b/common/xfs
> > index 9f84dffb..4c6374ed 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -103,7 +103,7 @@ _scratch_find_xfs_min_logblocks()
> >       # try again without MKFS_OPTIONS because that's what _scratch_do_=
mkfs
> >       # will do if we pass in the log size option.
> >       if [ $mkfs_status -ne 0 ] &&
> > -        ! egrep -q '(log size.*too small, minimum|external log device.=
*too small, must be)' $tmp.mkfserr; then
> > +        ! grep -E -q '(log size.*too small, minimum|external log devic=
e.*too small, must be)' $tmp.mkfserr; then
> >               eval "$mkfs_cmd $extra_mkfs_options $SCRATCH_DEV" \
> >                       2>$tmp.mkfserr 1>$tmp.mkfsstd
> >               mkfs_status=3D$?
> > @@ -181,7 +181,7 @@ _xfs_get_file_block_size()
> >  {
> >       local path=3D"$1"
> >
> > -     if ! ($XFS_IO_PROG -c "stat -v" "$path" 2>&1 | egrep -q '(rt-inhe=
rit|realtime)'); then
> > +     if ! ($XFS_IO_PROG -c "stat -v" "$path" 2>&1 | grep -E -q '(rt-in=
herit|realtime)'); then
> >               _get_block_size "$path"
> >               return
> >       fi
> > @@ -966,8 +966,8 @@ _scratch_xfs_set_metadata_field()
> >       done
> >
> >       local wr_cmd=3D"write"
> > -     _scratch_xfs_db -x -c "help write" | egrep -q "(-c|-d)" && value=
=3D"-- ${value}"
> > -     _scratch_xfs_db -x -c "help write" | egrep -q "(-d)" && wr_cmd=3D=
"${wr_cmd} -d"
> > +     _scratch_xfs_db -x -c "help write" | grep -E -q "(-c|-d)" && valu=
e=3D"-- ${value}"
> > +     _scratch_xfs_db -x -c "help write" | grep -E -q "(-d)" && wr_cmd=
=3D"${wr_cmd} -d"
> >       _scratch_xfs_db -x "${cmds[@]}" -c "${wr_cmd} ${key} ${value}"
> >  }
> >
> > @@ -1107,8 +1107,8 @@ _force_xfsv4_mount_options()
> >       local pquota=3D0
> >
> >       # Can't have group and project quotas in XFS v4
> > -     echo "$MOUNT_OPTIONS" | egrep -q "(gquota|grpquota|grpjquota=3D|g=
qnoenforce)" && gquota=3D1
> > -     echo "$MOUNT_OPTIONS" | egrep -q "(\bpquota|prjquota|pqnoenforce)=
" && pquota=3D1
> > +     echo "$MOUNT_OPTIONS" | grep -E -q "(gquota|grpquota|grpjquota=3D=
|gqnoenforce)" && gquota=3D1
> > +     echo "$MOUNT_OPTIONS" | grep -E -q "(\bpquota|prjquota|pqnoenforc=
e)" && pquota=3D1
> >
> >       if [ $gquota -gt 0 ] && [ $pquota -gt 0 ]; then
> >               export MOUNT_OPTIONS=3D$(echo $MOUNT_OPTIONS \
> > diff --git a/tests/btrfs/011 b/tests/btrfs/011
> > index 0665e126..6c3d037f 100755
> > --- a/tests/btrfs/011
> > +++ b/tests/btrfs/011
> > @@ -133,7 +133,7 @@ workout()
> >       _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
> >
> >       # Skip -r test for configs without mirror OR replace cancel
> > -     if echo $mkfs_options | egrep -qv "raid1|raid5|raid6|raid10" || \
> > +     if echo $mkfs_options | grep -E -qv "raid1|raid5|raid6|raid10" ||=
 \
> >          [ "${with_cancel}Q" =3D "cancelQ" ]; then
> >               _scratch_unmount > /dev/null 2>&1
> >               _scratch_dev_pool_put
> > diff --git a/tests/btrfs/100 b/tests/btrfs/100
> > index 9986a06e..410e83ba 100755
> > --- a/tests/btrfs/100
> > +++ b/tests/btrfs/100
> > @@ -37,7 +37,7 @@ _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
> >  $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_files=
ystem_show
> >
> >  error_devid=3D`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
> > -                     egrep $DMERROR_DEV | $AWK_PROG '{print $2}'`
> > +                     grep -E $DMERROR_DEV | $AWK_PROG '{print $2}'`
> >
> >  snapshot_cmd=3D"$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
> >  snapshot_cmd=3D"$snapshot_cmd $SCRATCH_MNT/snap_\`date +'%H_%M_%S_%N'\=
`"
> > diff --git a/tests/btrfs/101 b/tests/btrfs/101
> > index f0436f9f..e8ed8c5c 100755
> > --- a/tests/btrfs/101
> > +++ b/tests/btrfs/101
> > @@ -38,7 +38,7 @@ _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
> >  $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_files=
ystem_show
> >
> >  error_devid=3D`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
> > -                     egrep $DMERROR_DEV | $AWK_PROG '{print $2}'`
> > +                     grep -E $DMERROR_DEV | $AWK_PROG '{print $2}'`
> >
> >  snapshot_cmd=3D"$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
> >  snapshot_cmd=3D"$snapshot_cmd $SCRATCH_MNT/snap_\`date +'%H_%M_%S_%N'\=
`"
> > diff --git a/tests/btrfs/187 b/tests/btrfs/187
> > index 574636a6..d3cf05a1 100755
> > --- a/tests/btrfs/187
> > +++ b/tests/btrfs/187
> > @@ -219,7 +219,7 @@ wait $balance_pid
> >  # BTRFS error (device sdc): parent transid verify failed on 32243712 w=
anted 24 \
> >  #     found 27
> >  #
> > -_dmesg_since_test_start | egrep -e '\bBTRFS error \(device .*?\):'
> > +_dmesg_since_test_start | grep -E -e '\bBTRFS error \(device .*?\):'
> >
> >  status=3D0
> >  exit
> > diff --git a/tests/btrfs/252 b/tests/btrfs/252
> > index 65ebe571..8b4809b7 100755
> > --- a/tests/btrfs/252
> > +++ b/tests/btrfs/252
> > @@ -180,7 +180,7 @@ for i in "${!snapshots[@]}"; do
> >       # case, so we don't have a mismatch with the golden output in cas=
e we
> >       # run with a non default $LOAD_FACTOR (default is 1). We only wan=
t the
> >       # mismatch with the golden output in case there's a checksum fail=
ure.
> > -     $FSSUM_PROG -r "$snap_csum" "$snap_copy" | egrep -v '^OK$'
> > +     $FSSUM_PROG -r "$snap_csum" "$snap_copy" | grep -E -v '^OK$'
> >  done
> >
> >  echo "Silence is golden"
> > diff --git a/tests/ext4/006 b/tests/ext4/006
> > index 48ed6bee..8792167b 100755
> > --- a/tests/ext4/006
> > +++ b/tests/ext4/006
> > @@ -130,7 +130,7 @@ cat "$ROUND2_LOG" >> $seqres.full
> >  echo "++ check fs (2)" >> $seqres.full
> >  _check_scratch_fs >> $seqres.full 2>&1
> >
> > -egrep -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsc=
k failed" | tee -a $seqres.full
> > +grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2f=
sck failed" | tee -a $seqres.full
> >  if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
> >       echo "e2fsck did not fix everything" | tee -a $seqres.full
> >  fi
> > diff --git a/tests/generic/164 b/tests/generic/164
> > index 56c05e37..8ab71c72 100755
> > --- a/tests/generic/164
> > +++ b/tests/generic/164
> > @@ -50,7 +50,7 @@ _cp_reflink $testdir/file1 $testdir/file3
> >  _scratch_cycle_mount
> >
> >  fbytes() {
> > -     egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 =
62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> > +     grep -E -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 6=
2 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> >  }
> >
> >  reader() {
> > diff --git a/tests/generic/165 b/tests/generic/165
> > index bc24bcab..6deb6623 100755
> > --- a/tests/generic/165
> > +++ b/tests/generic/165
> > @@ -51,7 +51,7 @@ _cp_reflink $testdir/file1 $testdir/file3
> >  _scratch_cycle_mount
> >
> >  fbytes() {
> > -     egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 =
62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> > +     grep -E -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 6=
2 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> >  }
> >
> >  reader() {
> > diff --git a/tests/generic/454 b/tests/generic/454
> > index 133e2e9d..3c9b39d0 100755
> > --- a/tests/generic/454
> > +++ b/tests/generic/454
> > @@ -168,7 +168,7 @@ testf "combmark_\xe1\x80\x9c\xe1\x80\xad\xe1\x80\xa=
f.txt" "combining marks"
> >  testf "combmark_\xe1\x80\x9c\xe1\x80\xaf\xe1\x80\xad.txt" "combining m=
arks"
> >
> >  echo "Uniqueness of keys?"
> > -crazy_keys=3D"$(_getfattr --absolute-names -d "${testfile}" | egrep -c=
 '(french_|chinese_|greek_|arabic_|urk)')"
> > +crazy_keys=3D"$(_getfattr --absolute-names -d "${testfile}" | grep -E =
-c '(french_|chinese_|greek_|arabic_|urk)')"
> >  expected_keys=3D11
> >  test "${crazy_keys}" -ne "${expected_keys}" && echo "Expected ${expect=
ed_keys} keys, saw ${crazy_keys}."
> >
> > diff --git a/tests/generic/670 b/tests/generic/670
> > index 4a895d90..67de1674 100755
> > --- a/tests/generic/670
> > +++ b/tests/generic/670
> > @@ -43,7 +43,7 @@ fbytes() {
> >       # Different with generic/164,165, mread copies data from mmapped =
area
> >       # one-byte-at-a-time, which may cause races during reflink_range(=
).
> >       # So the result of _mread_range() may be a mix of 61 and 62.
> > -     egrep -v '((61|62) ){15}(61|62)'
> > +     grep -E -v '((61|62) ){15}(61|62)'
> >  }
> >
> >  reader() {
> > diff --git a/tests/xfs/008 b/tests/xfs/008
> > index a53f6c92..e7d6153b 100755
> > --- a/tests/xfs/008
> > +++ b/tests/xfs/008
> > @@ -46,7 +46,7 @@ _do_test()
> >               echo "holes is in range"
> >       else
> >               # quick check - how many holes did we get?
> > -             count=3D`xfs_bmap $out | egrep -c ': hole'`
> > +             count=3D`xfs_bmap $out | grep -E -c ': hole'`
> >               # blocks can end up adjacent, therefore number of holes v=
aries
> >               _within_tolerance "holes" $count $_holes 10% -v
> >       fi
> > diff --git a/tests/xfs/012 b/tests/xfs/012
> > index 5ebc9058..e0dccc4e 100755
> > --- a/tests/xfs/012
> > +++ b/tests/xfs/012
> > @@ -50,7 +50,7 @@ _do_test()
> >      if [ $failed -eq 0 ]
> >      then
> >          # quick check - how many holes did we get?
> > -        count=3D`xfs_bmap $out | egrep -c ': hole'`
> > +        count=3D`xfs_bmap $out | grep -E -c ': hole'`
> >          echo "    $count hole(s) detected"
> >          # and how big was the file?
> >          _filesize $out
> > diff --git a/tests/xfs/033 b/tests/xfs/033
> > index d47da0d6..ef5dc4fa 100755
> > --- a/tests/xfs/033
> > +++ b/tests/xfs/033
> > @@ -45,7 +45,7 @@ _check_root_inos()
> >  #
> >  _filter_bad_ids()
> >  {
> > -     egrep -v 'bad user id 0xffffffff|bad group id 0xffffffff'
> > +     grep -E -v 'bad user id 0xffffffff|bad group id 0xffffffff'
> >  }
> >
> >  # real QA test starts here
> > diff --git a/tests/xfs/064 b/tests/xfs/064
> > index a81b226b..f67c29fd 100755
> > --- a/tests/xfs/064
> > +++ b/tests/xfs/064
> > @@ -31,7 +31,7 @@ _ls_size_filter()
> >      # Filter out the housekeeping files of xfsrestore
> >      #
> >      $AWK_PROG 'NF =3D=3D 9 { print $5, $9 }' |\
> > -    egrep -v 'dumpdir|housekeeping|dirattr|dirextattr|namreg|state|tre=
e'
> > +    grep -E -v 'dumpdir|housekeeping|dirattr|dirextattr|namreg|state|t=
ree'
> >  }
> >
> >  # real QA test starts here
> > @@ -48,7 +48,7 @@ while [ $i -le 9 ]; do
> >      if [ $i -gt 0 ]; then
> >       sleep 2
> >       _modify_level $i
> > -    fi
> > +    fi
> >
> >      _stable_fs
> >      sleep 2
> > diff --git a/tests/xfs/065 b/tests/xfs/065
> > index 8485dee6..819d385e 100755
> > --- a/tests/xfs/065
> > +++ b/tests/xfs/065
> > @@ -37,7 +37,7 @@ _list_dir()
> >      find $__dir  -exec $here/src/lstat64 -t {} \; |\
> >      sed -e 's/.*dumpdir/dumpdir/' -e '/^dumpdir /d' |\
> >      sed -e 's/.*restoredir/restoredir/' -e '/^restoredir /d' |\
> > -    egrep -v 'housekeeping|dirattr|dirextattr|namreg|state|tree' |\
> > +    grep -E -v 'housekeeping|dirattr|dirextattr|namreg|state|tree' |\
> >      awk '$3 ~ /^d/ { $2 =3D "XXX" } {print}' |\
> >      LC_COLLATE=3DPOSIX sort
> >  }
> > diff --git a/tests/xfs/083 b/tests/xfs/083
> > index a9acc9f5..edab3b7b 100755
> > --- a/tests/xfs/083
> > +++ b/tests/xfs/083
> > @@ -145,7 +145,7 @@ cat "$ROUND2_LOG" >> $seqres.full
> >  echo "++ check fs (2)" >> $seqres.full
> >  _repair_scratch_fs >> $seqres.full 2>&1
> >
> > -egrep -q '(did not fix|makes no progress)' $seqres.full && echo "xfs_r=
epair failed" | tee -a $seqres.full
> > +grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "xfs=
_repair failed" | tee -a $seqres.full
> >  if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
> >       echo "xfs_repair did not fix everything" | tee -a $seqres.full
> >  fi
> > diff --git a/tests/xfs/122 b/tests/xfs/122
> > index 18748e67..91083d60 100755
> > --- a/tests/xfs/122
> > +++ b/tests/xfs/122
> > @@ -182,8 +182,8 @@ echo 'int main(int argc, char *argv[]) {' >>$cprog
> >  #
> >  cat /usr/include/xfs/xfs*.h | indent |\
> >  _attribute_filter |\
> > -egrep '(} *xfs_.*_t|^struct xfs_[a-z0-9_]*$)' |\
> > -egrep -v -f $tmp.ignore |\
> > +grep -E '(} *xfs_.*_t|^struct xfs_[a-z0-9_]*$)' |\
> > +grep -E -v -f $tmp.ignore |\
> >  sed -e 's/^.*}[[:space:]]*//g' -e 's/;.*$//g' -e 's/_t, /_t\n/g' |\
> >  sort | uniq |\
> >  awk '{printf("printf(\"sizeof(%s) =3D %%zu\\n\", sizeof(%s));\n", $0, =
$0);}' |\
> > diff --git a/tests/xfs/138 b/tests/xfs/138
> > index 966ac03a..c49d2d9e 100755
> > --- a/tests/xfs/138
> > +++ b/tests/xfs/138
> > @@ -33,7 +33,7 @@ echo "Test with interactive"
> >  (echo "sb 0"; sleep 0.5;
> >   echo "p magicnum"; sleep 0.5;
> >   echo "source $tmp.a"; sleep 0.5;
> > - echo "p magicnum"; sleep 0.5) | _scratch_xfs_db 2>&1 | sed -e 's/xfs_=
db> //g' -e 's/0x58465342/XFS_MAGIC/g' | egrep '(This is file|magicnum =3D)=
'
> > + echo "p magicnum"; sleep 0.5) | _scratch_xfs_db 2>&1 | sed -e 's/xfs_=
db> //g' -e 's/0x58465342/XFS_MAGIC/g' | grep -E '(This is file|magicnum =
=3D)'
> >
> >  # success, all done
> >  status=3D0
> > diff --git a/tests/xfs/185 b/tests/xfs/185
> > index f0e87642..73b21092 100755
> > --- a/tests/xfs/185
> > +++ b/tests/xfs/185
> > @@ -108,7 +108,7 @@ expected_end=3D"$(( (alloc_rtx * rtextsize - 1) / 5=
12 ))"
> >  # file_offset file_end physical_offset physical_end
> >  rtfile_exts() {
> >       $XFS_IO_PROG -c 'bmap -elp' $rtfile | \
> > -             egrep -v '(^/|EXT:|hole)' | \
> > +             grep -E -v '(^/|EXT:|hole)' | \
> >               tr ':.[]' '    ' | \
> >               while read junk foff fend physoff physend junk; do
> >                       echo "$foff $fend $physoff $physend"
> > diff --git a/tests/xfs/186 b/tests/xfs/186
> > index b54fcf26..f44158e3 100755
> > --- a/tests/xfs/186
> > +++ b/tests/xfs/186
> > @@ -55,8 +55,8 @@ _filter_inode()
> >  {
> >       tee -a $seqres.full | \
> >               sed -e "s/core.forkoff/forkoff/g" | \
> > -             egrep '^u.sfdir2|^u.sfdir3|^a.sfattr|forkoff' | \
> > -             egrep -v 'inumber|parent' | \
> > +             grep -E '^u.sfdir2|^u.sfdir3|^a.sfattr|forkoff' | \
> > +             grep -E -v 'inumber|parent' | \
> >               sed -e s/sfdir3/sfdir2/g | \
> >               grep -v filetype
> >  }
> > diff --git a/tests/xfs/293 b/tests/xfs/293
> > index 20f8c486..7a17eb81 100755
> > --- a/tests/xfs/293
> > +++ b/tests/xfs/293
> > @@ -33,7 +33,7 @@ esac
> >  _require_command "$(type -P $CAT)" $CAT
> >
> >  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Us=
e"`; do
> > -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> > +  $CAT "$MANPAGE" | grep -E -q "^\.B.*$COMMAND" || \
> >       echo "$COMMAND not documented in the xfs_io manpage"
> >  done
> >
> > diff --git a/tests/xfs/330 b/tests/xfs/330
> > index 40be4c46..5a82a1fd 100755
> > --- a/tests/xfs/330
> > +++ b/tests/xfs/330
> > @@ -26,7 +26,7 @@ _require_nobody
> >
> >  do_repquota()
> >  {
> > -     repquota $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)' | sort -r
> > +     repquota $SCRATCH_MNT | grep -E '^(fsgqa|root|nobody)' | sort -r
> >  }
> >
> >  rm -f "$seqres.full"
> > diff --git a/tests/xfs/422 b/tests/xfs/422
> > index fdbb8bf1..f3c63e8d 100755
> > --- a/tests/xfs/422
> > +++ b/tests/xfs/422
> > @@ -73,7 +73,7 @@ cpus=3D$(( $($here/src/feature -o) * 4 * LOAD_FACTOR)=
)
> >
> >  echo "Concurrent repair"
> >  filter_output() {
> > -     egrep -v '(Device or resource busy|Invalid argument)'
> > +     grep -E -v '(Device or resource busy|Invalid argument)'
> >  }
> >  freeze_loop() {
> >       end=3D"$1"
> > diff --git a/tests/xfs/499 b/tests/xfs/499
> > index b5597708..9672f95d 100755
> > --- a/tests/xfs/499
> > +++ b/tests/xfs/499
> > @@ -44,7 +44,7 @@ struct ftrace_chk {
> >       char                    *str;
> >  } syms[] =3D {
> >  ENDL
> > -egrep '(__print_flags|__print_symbolic)' $ftrace_dir*/*/format | \
> > +grep -E '(__print_flags|__print_symbolic)' $ftrace_dir*/*/format | \
> >       sed -f $sedprog | grep '^{' | sort | uniq >> $cprog
> >  cat >> $cprog << ENDL
> >  };
> > diff --git a/tests/xfs/505 b/tests/xfs/505
> > index 71fb6e9d..0601b1a8 100755
> > --- a/tests/xfs/505
> > +++ b/tests/xfs/505
> > @@ -29,7 +29,7 @@ esac
> >  _require_command "$(type -P $CAT)" $CAT
> >
> >  for COMMAND in `$XFS_SPACEMAN_PROG -c help $TEST_DIR | awk '{print $1}=
' | grep -v "^Use"`; do
> > -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> > +  $CAT "$MANPAGE" | grep -E -q "^\.B.*$COMMAND" || \
> >       echo "$COMMAND not documented in the xfs_spaceman manpage"
> >  done
> >
> > diff --git a/tests/xfs/514 b/tests/xfs/514
> > index cf5588f2..94f98398 100755
> > --- a/tests/xfs/514
> > +++ b/tests/xfs/514
> > @@ -41,7 +41,7 @@ truncate -s 128m $file
> >  $MKFS_XFS_PROG $file >> /dev/null
> >
> >  for COMMAND in `$XFS_DB_PROG -x -c help $file | awk '{print $1}' | gre=
p -v "^Use"`; do
> > -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> > +  $CAT "$MANPAGE" | grep -E -q "^\.B.*$COMMAND" || \
> >       echo "$COMMAND not documented in the xfs_db manpage"
> >  done
> >
> > diff --git a/tests/xfs/515 b/tests/xfs/515
> > index 2d7bbb35..adb2bd6f 100755
> > --- a/tests/xfs/515
> > +++ b/tests/xfs/515
> > @@ -37,7 +37,7 @@ esac
> >  _require_command "$(type -P $CAT)" $CAT
> >
> >  for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | =
grep -v "^Use"`; do
> > -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> > +  $CAT "$MANPAGE" | grep -E -q "^\.B.*$COMMAND" || \
> >       echo "$COMMAND not documented in the xfs_quota manpage"
> >  done
> >
> > diff --git a/tests/xfs/517 b/tests/xfs/517
> > index 6877af13..99fc89b0 100755
> > --- a/tests/xfs/517
> > +++ b/tests/xfs/517
> > @@ -70,7 +70,7 @@ cpus=3D$(( $(src/feature -o) * 4 * LOAD_FACTOR))
> >
> >  echo "Concurrent fsmap and freeze"
> >  filter_output() {
> > -     egrep -v '(Device or resource busy|Invalid argument)'
> > +     grep -E -v '(Device or resource busy|Invalid argument)'
> >  }
> >  freeze_loop() {
> >       end=3D"$1"
> > diff --git a/tests/xfs/520 b/tests/xfs/520
> > index 2fceb07c..dd6d845e 100755
> > --- a/tests/xfs/520
> > +++ b/tests/xfs/520
> > @@ -52,7 +52,7 @@ force_crafted_metadata() {
> >       fi
> >
> >       _dmesg_since_test_start | tac | sed -ne "0,\#${kmsg}#p" | tac | \
> > -             egrep -q 'Metadata corruption detected at' && hasmsg=3D1
> > +             grep -E -q 'Metadata corruption detected at' && hasmsg=3D=
1
> >
> >       _scratch_unmount > /dev/null 2>&1
> >       [ $mounted -eq 0 -o $hasmsg -eq 1 ] || \
> > diff --git a/tests/xfs/530 b/tests/xfs/530
> > index 9c6f44d7..c960738d 100755
> > --- a/tests/xfs/530
> > +++ b/tests/xfs/530
> > @@ -73,7 +73,7 @@ _try_scratch_mount || _notrun "Couldn't mount fs with=
 synthetic rt volume"
> >  formatted_blksz=3D"$(_get_block_size $SCRATCH_MNT)"
> >  test "$formatted_blksz" -ne "$dbsize" && \
> >       _notrun "Tried to format with $dbsize blocksize, got $formatted_b=
lksz."
> > -$XFS_INFO_PROG $SCRATCH_MNT | egrep -q 'realtime.*blocks=3D0' && \
> > +$XFS_INFO_PROG $SCRATCH_MNT | grep -E -q 'realtime.*blocks=3D0' && \
> >       _notrun "Filesystem should have a realtime volume"
> >
> >  echo "Consume free space"
> > diff --git a/tests/xfs/539 b/tests/xfs/539
> > index 77b44c89..778dce85 100755
> > --- a/tests/xfs/539
> > +++ b/tests/xfs/539
> > @@ -36,7 +36,7 @@ dmesg_since_test_tag()
> >
> >  check_dmesg_for_since_tag()
> >  {
> > -     dmesg_since_test_tag | egrep -q "$1"
> > +     dmesg_since_test_tag | grep -E -q "$1"
> >  }
> >
> >  echo "Silence is golden."
> > --
> > 2.31.1
> >
>
