Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A1C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 03:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiITDSK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiITDSI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Sep 2022 23:18:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0ADEE9
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 20:18:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w13so1108745plp.1
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 20:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Yg0QK/b7RX961OkyyjvdQeG+X1maiFxsSN1G+WxNX5E=;
        b=dEZY1fM0FssRmqAQ12xis5WIwhc6/SCKQeXN3WPi0FkN01JmK+6AWL8n4E25I8VLOr
         m0Q2IFZCvfXouYLMqJMs9DSuD1l3xEdhh2Z1jIW1QWq/3Bdwg32W2hzs4OyECC1obPtV
         sNg2oWOqn4N5gmXoshcj/kjAzWDV7FxWU5jIiXU9YjPWbQJx/DjpNHQCAeLiec/A/ZaB
         dHLkLTPjWGeRiZ5+lk9aETRWZuHKhE1R2WuVdxe8dTa5/SZJiPECfLs4dRLqVCRzgVqL
         gJs8Yje7FZmcsE6KVSaakTyBw30pOe5OW1XnuQv8mi7pIPPphUhMHGlOmafcLBRba6Xh
         jS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Yg0QK/b7RX961OkyyjvdQeG+X1maiFxsSN1G+WxNX5E=;
        b=KuFsZYb4BwQNjtvMuSY38si5mY75GKTULPsldmXcCF66+0tFDZl7HXSk9IpQbHRZTs
         W83hFVxQHZYkooD56TKKwktFyZO/0ndnpL91sP+J3KukzHeCuSx8tUh1neTC6bQ/su9y
         bfGOCTo+gs/DxnS2YC++qgaDzO9oyyMxiuTf8VM5snsTrCWSBcKLc9EthGo+Yejj0WoV
         RCiiIyb+xaHeUhpFj4G4s0HeL8ijPSnS7GG6Fus4gV1j9ohu/Kv/+WNNkzLsBrYJy0H+
         wpMB7NYMV18N77SAt6Ra0VtaxTVqSUcwhafE+KLgpFldVpUEhypt1m9RVchz6GMsymMT
         ACyA==
X-Gm-Message-State: ACrzQf1wZk7ydGfmy+5z00iABnrlE+M0pzsHPTYcDMJ/LSkxg46lJ4B4
        seujngvy4LL+xM1jKdxU2js/ZgHfOYJRgV5pvWU=
X-Google-Smtp-Source: AMsMyM4cocdZ2BQ7aCix9jml5eKIhmqkoCKs9CWcF4plVirxAuXJ4mxlrG+gt5wE6fteLO2zCIESjqALtxYChVld7X0=
X-Received: by 2002:a17:902:d1d5:b0:178:a537:1645 with SMTP id
 g21-20020a170902d1d500b00178a5371645mr2859324plb.158.1663643884512; Mon, 19
 Sep 2022 20:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220914090610.1994485-1-jencce.kernel@gmail.com> <20220915081048.2uibaxxx5k6b4oko@zlang-mailbox>
In-Reply-To: <20220915081048.2uibaxxx5k6b4oko@zlang-mailbox>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Tue, 20 Sep 2022 11:17:52 +0800
Message-ID: <CADJHv_swYav2=GcPxiBbYcwkCgLssbZRCFHT12Mo6XYhkrgNkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] egrep, fgrep: deprecated
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi

On Thu, Sep 15, 2022 at 4:10 PM Zorro Lang <zlang@redhat.com> wrote:
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
> Hi,
>
> Please rebase this patch on latest fstests for-next branch, I hit below
> CONFLICT when I try to merge it:
>
>   $ git am -3 ./20220914_jencce_kernel_egrep_fgrep_deprecated.mbx
>   Applying: egrep, fgrep: deprecated
>   Using index info to reconstruct a base tree...
>   M       check
>   M       common/encrypt
>   M       common/rc
>   M       common/xfs
>   Falling back to patching base and 3-way merge...
>   Auto-merging common/xfs
>   Auto-merging common/rc
>   CONFLICT (content): Merge conflict in common/rc
>   Auto-merging common/encrypt
>   Auto-merging check
>   error: Failed to merge in the changes.
>   Patch failed at 0001 egrep, fgrep: deprecated
>   hint: Use 'git am --show-current-patch=diff' to see the failed patch
>   When you have resolved this problem, run "git am --continue".
>   If you prefer to skip this patch, run "git am --skip" instead.
>   To restore the original branch and stop patching, run "git am --abort".

Rebased. Will send v2.
>
> One more tiny question below ...
>
> >  check              |  2 +-
> >  common/btrfs       |  4 ++--
> >  common/dmlogwrites |  2 +-
> >  common/dump        |  4 ++--
>
> [snip]
>
> >  # real QA test starts here
> > @@ -48,7 +48,7 @@ while [ $i -le 9 ]; do
> >      if [ $i -gt 0 ]; then
> >       sleep 2
> >       _modify_level $i
> > -    fi
> > +    fi
>
> What's this change for?

Cleaned a trailing whitespace up by the way.

Thanks for the review!

Regards~

>
> Thanks,
> Zorro
>
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
> >      awk '$3 ~ /^d/ { $2 = "XXX" } {print}' |\
> >      LC_COLLATE=POSIX sort
> >  }
> > diff --git a/tests/xfs/083 b/tests/xfs/083
> > index a9acc9f5..edab3b7b 100755
> > --- a/tests/xfs/083
> > +++ b/tests/xfs/083
> > @@ -145,7 +145,7 @@ cat "$ROUND2_LOG" >> $seqres.full
> >  echo "++ check fs (2)" >> $seqres.full
> >  _repair_scratch_fs >> $seqres.full 2>&1
> >
> > -egrep -q '(did not fix|makes no progress)' $seqres.full && echo "xfs_repair failed" | tee -a $seqres.full
> > +grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "xfs_repair failed" | tee -a $seqres.full
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
> >  awk '{printf("printf(\"sizeof(%s) = %%zu\\n\", sizeof(%s));\n", $0, $0);}' |\
> > diff --git a/tests/xfs/138 b/tests/xfs/138
> > index 966ac03a..c49d2d9e 100755
> > --- a/tests/xfs/138
> > +++ b/tests/xfs/138
> > @@ -33,7 +33,7 @@ echo "Test with interactive"
> >  (echo "sb 0"; sleep 0.5;
> >   echo "p magicnum"; sleep 0.5;
> >   echo "source $tmp.a"; sleep 0.5;
> > - echo "p magicnum"; sleep 0.5) | _scratch_xfs_db 2>&1 | sed -e 's/xfs_db> //g' -e 's/0x58465342/XFS_MAGIC/g' | egrep '(This is file|magicnum =)'
> > + echo "p magicnum"; sleep 0.5) | _scratch_xfs_db 2>&1 | sed -e 's/xfs_db> //g' -e 's/0x58465342/XFS_MAGIC/g' | grep -E '(This is file|magicnum =)'
> >
> >  # success, all done
> >  status=0
> > diff --git a/tests/xfs/185 b/tests/xfs/185
> > index f0e87642..73b21092 100755
> > --- a/tests/xfs/185
> > +++ b/tests/xfs/185
> > @@ -108,7 +108,7 @@ expected_end="$(( (alloc_rtx * rtextsize - 1) / 512 ))"
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
> >  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
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
> > @@ -73,7 +73,7 @@ cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR))
> >
> >  echo "Concurrent repair"
> >  filter_output() {
> > -     egrep -v '(Device or resource busy|Invalid argument)'
> > +     grep -E -v '(Device or resource busy|Invalid argument)'
> >  }
> >  freeze_loop() {
> >       end="$1"
> > diff --git a/tests/xfs/499 b/tests/xfs/499
> > index b5597708..9672f95d 100755
> > --- a/tests/xfs/499
> > +++ b/tests/xfs/499
> > @@ -44,7 +44,7 @@ struct ftrace_chk {
> >       char                    *str;
> >  } syms[] = {
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
> >  for COMMAND in `$XFS_SPACEMAN_PROG -c help $TEST_DIR | awk '{print $1}' | grep -v "^Use"`; do
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
> >  for COMMAND in `$XFS_DB_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
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
> >  for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
> > -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> > +  $CAT "$MANPAGE" | grep -E -q "^\.B.*$COMMAND" || \
> >       echo "$COMMAND not documented in the xfs_quota manpage"
> >  done
> >
> > diff --git a/tests/xfs/517 b/tests/xfs/517
> > index 6877af13..99fc89b0 100755
> > --- a/tests/xfs/517
> > +++ b/tests/xfs/517
> > @@ -70,7 +70,7 @@ cpus=$(( $(src/feature -o) * 4 * LOAD_FACTOR))
> >
> >  echo "Concurrent fsmap and freeze"
> >  filter_output() {
> > -     egrep -v '(Device or resource busy|Invalid argument)'
> > +     grep -E -v '(Device or resource busy|Invalid argument)'
> >  }
> >  freeze_loop() {
> >       end="$1"
> > diff --git a/tests/xfs/520 b/tests/xfs/520
> > index 2fceb07c..dd6d845e 100755
> > --- a/tests/xfs/520
> > +++ b/tests/xfs/520
> > @@ -52,7 +52,7 @@ force_crafted_metadata() {
> >       fi
> >
> >       _dmesg_since_test_start | tac | sed -ne "0,\#${kmsg}#p" | tac | \
> > -             egrep -q 'Metadata corruption detected at' && hasmsg=1
> > +             grep -E -q 'Metadata corruption detected at' && hasmsg=1
> >
> >       _scratch_unmount > /dev/null 2>&1
> >       [ $mounted -eq 0 -o $hasmsg -eq 1 ] || \
> > diff --git a/tests/xfs/530 b/tests/xfs/530
> > index 9c6f44d7..c960738d 100755
> > --- a/tests/xfs/530
> > +++ b/tests/xfs/530
> > @@ -73,7 +73,7 @@ _try_scratch_mount || _notrun "Couldn't mount fs with synthetic rt volume"
> >  formatted_blksz="$(_get_block_size $SCRATCH_MNT)"
> >  test "$formatted_blksz" -ne "$dbsize" && \
> >       _notrun "Tried to format with $dbsize blocksize, got $formatted_blksz."
> > -$XFS_INFO_PROG $SCRATCH_MNT | egrep -q 'realtime.*blocks=0' && \
> > +$XFS_INFO_PROG $SCRATCH_MNT | grep -E -q 'realtime.*blocks=0' && \
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
