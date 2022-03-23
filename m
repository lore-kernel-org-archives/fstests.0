Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B19C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Mar 2022 02:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiCWCk0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiCWCkZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 22:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 578F3673ED
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648003133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhW9oFGazdbwGzYXlENW+DcHUUYOjaNmuzjK4zVDbLE=;
        b=Mq0qOKBKlgYbulQpuphhYu7n/7Vt4DWb6BSbvixS8DMPKvCadhSLNXsiq/BZnNEmLzhUj0
        hr+R12I3gDtzoD4ktoB5yXzZFEbC4VTUyZB1tssyTvKgmCUqEBiN7gTVTX6Ktsx0lc2hVO
        CGbp2FpvOUroMuI3gXo492Z6maa9DXk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-bf6Cv7qOPQiT2lEt2_QViw-1; Tue, 22 Mar 2022 22:38:52 -0400
X-MC-Unique: bf6Cv7qOPQiT2lEt2_QViw-1
Received: by mail-pg1-f199.google.com with SMTP id x5-20020a637c05000000b003817f40e072so46348pgc.17
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 19:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nhW9oFGazdbwGzYXlENW+DcHUUYOjaNmuzjK4zVDbLE=;
        b=bCVeULGSSeGkOTj9kR/4dXVM15UC/tu8YDFrr/0bX06DPAFW91/Y4cj/avfkmBKCop
         oCf7xs4UvN3RvfpuCbNG1md9VQ/gIGk5t1AhJxRD2AltuUY3RjpGcPyyPLBgNP+1sqQo
         sRA8R2b3FSVArFdpUCK8eF0ALTUPAFxgm0SlAnAIbdzW0UXrQkRv5kpYgKE3VN+5uTJS
         uYNG8D4NVJOWHlJmxQhnykPguAW9Go0W/krwxXrDInm2qPar6blFCKdBoTmgJcUZHS3A
         AP7VlM/HcQFMEsl9DoJjf6q9+xTqnO+4pY6mECf4qk33zw31eP3csnlbGAMyqcUGrqKk
         XtRA==
X-Gm-Message-State: AOAM531EiljmUhQAFLT387qgBueo37xJ+7nGTdQub2B7OP8H9jmy1deT
        IKiSK1t6AOMVOS2i2WmltTmqZVg737MkMIy/5HfBhkZqyv2U+GfttBA6+/VuPKJehDUFj6O4kUd
        GBl7MS/9AOkfOfo2Rrw==
X-Received: by 2002:a05:6a00:24c2:b0:4f7:282c:4397 with SMTP id d2-20020a056a0024c200b004f7282c4397mr31838058pfv.78.1648003130708;
        Tue, 22 Mar 2022 19:38:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUcwI4u26q+3s/15rDj49rrrUxy1ZmtxXP0XnXZp+I8btek+fHECdVcGReaEZryc/+I6UKaQ==
X-Received: by 2002:a05:6a00:24c2:b0:4f7:282c:4397 with SMTP id d2-20020a056a0024c200b004f7282c4397mr31838032pfv.78.1648003130318;
        Tue, 22 Mar 2022 19:38:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a0010c900b004f774c13e96sm25166977pfu.19.2022.03.22.19.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 19:38:49 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:38:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     bxue@redhat.com, fstests@vger.kernel.org
Subject: Re: [PATCH v1 2/2] generic/513,675: check for security namespace
 support
Message-ID: <20220323023845.saj5en74km7aibdx@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, bxue@redhat.com,
        fstests@vger.kernel.org
References: <20220317100842.1237893-1-bxue@redhat.com>
 <20220317100842.1237893-3-bxue@redhat.com>
 <20220317153038.GH8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317153038.GH8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 17, 2022 at 08:30:38AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 17, 2022 at 06:08:42PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> > 
> 
> Er... what does this patch do, and why?

I think he's trying to avoid this failure on NFS:
  # setcap cap_net_raw=eip /mnt/nfs/file
  Failed to set capabilities on file `/mnt/nfs/file' (Operation not supported)

NFS doesn't support capabilities for long time, some other filesystems
might have same problem. So maybe we can have a helper [1], then call it as:

_require_capabilities

or

_require_capabilities cap_setuid cap_setgid

And test cases need capabilites as [2], I think we can add this requirement
in generic test at least (or all of them). What do you think?

Thanks,
Zorro


[1]
_require_capabilities()
{
	local capabilities=$*
	local tmp=`mktemp -u $TEST_DIR/capbility-XXXXXX`

	# Try all capabilities by default
	if [ -z "$capabilities" ];then
		capabilities="all"
	fi

	_require_command "$SETCAP_PROG" setcap
	rm -f $tmp.test
	rm -f $tmp.out

	for cap in $capabilities; do
		touch $tmp.test
		$SETCAP_PROG ${cap}=eip $tmp.test > $tmp.out 2>&1
		cat $tmp.out >> $seqres.full
		if grep -q 'Operation not supported' $tmp.out; then
			_notrun "Filesystem $FSTYP does not support to set $cap capability"
		fi
		if grep -q 'Invalid argument' $tmp.out; then
			_notrun "Capability $cap might not be supported by current system"
		fi
		rm -f $tmp.out
		rm -f $tmp.test
	done
	
}

[2]
[zorro@zlang-laptop xfstests-dev]$ grep -rsni SETCAP tests/
tests/btrfs/214:19:_require_command "$SETCAP_PROG" setcap
tests/btrfs/214:75:     $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
tests/btrfs/214:99:     $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
tests/btrfs/214:106:    $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
tests/btrfs/214:115:    $SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
tests/btrfs/235:29:_require_command "$SETCAP_PROG" setcap
tests/btrfs/235:48:$SETCAP_PROG cap_net_raw=p $SCRATCH_MNT/foo
tests/btrfs/235:67:$SETCAP_PROG cap_net_raw=p $SCRATCH_MNT/bar
tests/btrfs/235:71:$SETCAP_PROG cap_sys_nice=ep $SCRATCH_MNT/foo2
tests/overlay/064:18:_require_command "$SETCAP_PROG" setcap
tests/overlay/064:31:$SETCAP_PROG cap_setuid+ep ${lowerdir}/file1
tests/overlay/064:32:$SETCAP_PROG cap_setuid+ep ${lowerdir}/file2
tests/xfs/296:29:_require_command "$SETCAP_PROG" setcap
tests/xfs/296:39:$SETCAP_PROG cap_setgid,cap_setuid+ep $dump_dir/testfile
tests/generic/675:22:_require_command "$SETCAP_PROG" setcap
tests/generic/675:34:   $SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/a
tests/generic/513:20:_require_command "$SETCAP_PROG" setcap
tests/generic/513:28:$SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/bar
tests/generic/093:35:_require_command "$SETCAP_PROG" "setcap"
tests/generic/093:45:$SETCAP_PROG cap_chown+ep $file
tests/generic/093:53:$SETCAP_PROG cap_chown+ep $file
tests/generic/270:31:   $SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
tests/generic/270:60:_require_command "$SETCAP_PROG" setcap

> 
> --D
> 
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> >  tests/generic/513 | 2 ++
> >  tests/generic/675 | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/tests/generic/513 b/tests/generic/513
> > index dc082787..6e897fa0 100755
> > --- a/tests/generic/513
> > +++ b/tests/generic/513
> > @@ -12,10 +12,12 @@ _begin_fstest auto quick clone
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/reflink
> > +. ./common/attr
> >  
> >  # real QA test starts here
> >  _supported_fs generic
> >  _require_scratch_reflink
> > +_require_attrs security
> >  _require_command "$GETCAP_PROG" getcap
> >  _require_command "$SETCAP_PROG" setcap
> >  
> > diff --git a/tests/generic/675 b/tests/generic/675
> > index 23b7e545..311860dc 100755
> > --- a/tests/generic/675
> > +++ b/tests/generic/675
> > @@ -12,12 +12,14 @@ _begin_fstest auto clone quick
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/reflink
> > +. ./common/attr
> >  
> >  # real QA test starts here
> >  
> >  # Modify as appropriate.
> >  _supported_fs generic
> >  _require_user
> > +_require_attrs security
> >  _require_command "$GETCAP_PROG" getcap
> >  _require_command "$SETCAP_PROG" setcap
> >  _require_scratch_reflink
> > -- 
> > 2.27.0
> > 
> 

