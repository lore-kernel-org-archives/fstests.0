Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D7C43334
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 00:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiGHAeV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 20:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiGHAeV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 20:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CCAF6D558
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657240459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXq2TDpynvuTL+zeJ0cTMubx+c5EijRwdh6HytynH1k=;
        b=C2v6UIUMAZaTT5cxisw1kE+Q8MfBCjHl4EJ+IXEC/NNUy0L05J5enuvnIKScQ304MHeMVA
        SnVaN2wOaa4ki8v9wwRmLpdxANeAJciaiWBZiTmpxED2KsVkSZjo/QoYH98dhC7ksOlZO1
        QGx3dnaOytDEI7KEUxKwSdWoEGfXxr8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-EtCiIAqYOA6B497VzDlO4w-1; Thu, 07 Jul 2022 20:34:18 -0400
X-MC-Unique: EtCiIAqYOA6B497VzDlO4w-1
Received: by mail-qk1-f200.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso2304859qko.4
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2022 17:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXq2TDpynvuTL+zeJ0cTMubx+c5EijRwdh6HytynH1k=;
        b=Q8F6Awk3ejeZfxZR3NC1LAeTVb1jsPlj29y8blnUuXHgZRuodCsan4Clx0F9VxQ4O1
         HsyVHdTznLZVVO9lJXY5RKL4QDRo5vRQQCakrr7YaoGPBnmZmWsvGzoJPnHGF89CEfyf
         RupraxTTVuyRi5CIRYlS9th1XWao4/wds2vzczKCuaWwVWS33TQ5LxpiMDC8BT1tUxlc
         Zyjgrm4MDnYAH9DAGRypQZUt1HhdjgOF+ERLjZqb8FGGQNm2yc6ljFV57pd4gPfTROwi
         t6RMICgUOHq646Kjl1eUN/wUYzjHcDH9xQkSmYZgAoK3F5h03JOrZdCtJHxm6Tv5Elg1
         deQQ==
X-Gm-Message-State: AJIora/CVB1349pXAxysyx69HgHCdzYm91WW6qtITJb8AyVUVKp6fjJH
        Ob52zHLk4Iet0+3mZkBZnAsE36qAETV5iClyjkMcL48IFnS65yjycrM6PDFFwD+IQc0YSaD20Rr
        s+gHRVYBEwamjoWiT5A==
X-Received: by 2002:a05:620a:2592:b0:6b2:7b63:9772 with SMTP id x18-20020a05620a259200b006b27b639772mr525036qko.119.1657240457726;
        Thu, 07 Jul 2022 17:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNdrywICJcztT/Cr/VJhYBn6XY3yGVfldQyDSGKPYDyvKQwg26wFdAwPEkCkmKyngjHBosfA==
X-Received: by 2002:a05:620a:2592:b0:6b2:7b63:9772 with SMTP id x18-20020a05620a259200b006b27b639772mr525018qko.119.1657240457424;
        Thu, 07 Jul 2022 17:34:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a0bca00b006af0ce13499sm33653749qki.115.2022.07.07.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 17:34:16 -0700 (PDT)
Date:   Fri, 8 Jul 2022 08:34:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v3 5/5] check: add -L <n> parameter to rerun failed tests
Message-ID: <20220708003410.kgxq44rnmcvjmdoh@zlang-mailbox>
References: <20220706112312.4349-1-ddiss@suse.de>
 <20220706112312.4349-6-ddiss@suse.de>
 <YsXbt85xBNJIOwZu@magnolia>
 <20220706235452.694341f0@suse.de>
 <20220707200936.66d1b30d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707200936.66d1b30d@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 07, 2022 at 08:09:36PM +0200, David Disseldorp wrote:
> On Wed, 6 Jul 2022 23:54:52 +0200, David Disseldorp wrote:
> 
> > Thanks for the follow-up feedback, Darrick...
> > 
> > On Wed, 6 Jul 2022 12:00:07 -0700, Darrick J. Wong wrote:
> ...
> > > >  
> > > > +# retain files which would be overwritten in subsequent reruns of the same test
> > > > +_stash_fail_loop_files() {
> > > > +	local test_seq="$1"
> > > > +	local suffix="$2"
> > > > +
> > > > +	for i in "${REPORT_DIR}/${test_seq}.full" \
> > > > +		 "${REPORT_DIR}/${test_seq}.dmesg" \
> > > > +		 "${REPORT_DIR}/${test_seq}.out.bad"; do
> > > > +		[ -f "$i" ] && cp "$i" "${i}${suffix}"    
> > > 
> > > I wonder, is there any particular reason to copy the output file and let
> > > it get overwritten instead of simply mv'ing it?  
> > 
> > The copy is left over from an earlier version I had where xunit report
> > generation was done after the copy. Looking closer:
> > - .full is removed in _begin_fstest()
> > - _check_dmesg() overwrites .dmesg and retains on failure or KEEP_DMESG
> > - out.bad is removed in the main check loop prior to seq invocation
> > - .notrun, .core and .hints are also removed in the check loop at
> >   various places before seq (.hints again in _begin_fstest())
> > 
> > One concern I have in changing this to a move is that external scripts
> > may check for presence / parse these files after check invocation. I'd
> > considered moving and then copying / symlinking back the .rerun0 files
> > on rerun-on-failure loop completion but that's also pretty ugly. IMO
> > leaving this as a copy, with the non-suffix file state left to reflect
> > the results of the last rerun-on-failure loop, would make the most
> > sense for now.
> 
> As a follow up here, I plan on squashing in the following change to
> cover the extra notrun, core and hints files, and also avoid stale
> .rerun# state:

OK, will wait your v4 of this patch, hope to catch the release of this week.

Thanks,
Zorro

> 
> --- a/check
> +++ b/check
> @@ -560,13 +560,14 @@ _expunge_test()
>  
>  # retain files which would be overwritten in subsequent reruns of the same test
>  _stash_fail_loop_files() {
> -       local test_seq="$1"
> -       local suffix="$2"
> +       local seq_prefix="${REPORT_DIR}/${1}"
> +       local cp_suffix="$2"
>  
> -       for i in "${REPORT_DIR}/${test_seq}.full" \
> -                "${REPORT_DIR}/${test_seq}.dmesg" \
> -                "${REPORT_DIR}/${test_seq}.out.bad"; do
> -               [ -f "$i" ] && cp "$i" "${i}${suffix}"
> +       for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints"; do
> +               rm -f "${seq_prefix}${i}${cp_suffix}"
> +               if [ -f "${seq_prefix}${i}" ]; then
> +                       cp "${seq_prefix}${i}" "${seq_prefix}${i}${cp_suffix}"
> +               fi
>         done
>  }
> 
> Cheers, David
> 

