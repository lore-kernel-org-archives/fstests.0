Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85AC001DD
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Jul 2023 03:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGHDDD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 23:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGHDDA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 23:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637FD1BDB
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688785332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNCuHFyVpo50sLNkDOt0IOVvvoaNewQFzHIkXwDOatk=;
        b=LwgcCO7C5tg2ewRTc5N2i4EBKrz73KZ2oO8csJeTRVPhtPb3Kbuw0cUn/+YBtvy4A02D5P
        5Mi+nLoFoEqNiy9VClJOaACjUKU/+h0M0Y6kppo8jKokjT0KtgiRUtHk9w01toL1IBunF5
        7Oe2fO+HiQSV2xiJVZO5Oqg48Gsj63U=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-FoWthXmrOz-er4Q1ARKcrA-1; Fri, 07 Jul 2023 23:02:11 -0400
X-MC-Unique: FoWthXmrOz-er4Q1ARKcrA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5634c4df8c4so1984754eaf.1
        for <fstests@vger.kernel.org>; Fri, 07 Jul 2023 20:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688785330; x=1691377330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNCuHFyVpo50sLNkDOt0IOVvvoaNewQFzHIkXwDOatk=;
        b=Es4X6AvzXDnLTxGtq0hMT4abEFWBwB02q8JWKZ7dD5GK+5HJ5H1+512xJhJDZnDrce
         slCq1qjDCwXUUbROJOUUdB2Kq2SA9LHZAfMP2z42auLnUDVygNu6CiFn5B6ip+YFG9+G
         bMJAU1bnDm3Y2LYgFsW6hRJoOMvV5USBjByow4kvknSLNj5xaR2eA/gVyFxyx7ToDkUb
         CTB19fdwkxm7ywUyA8WOMiyxBRgwOGK0DVTaPTvFciwKWFv1l5knqsABEtY1BZ48UGtB
         bxQbNnw7GyQ3a8Yc4Vq8FBKhvnWJiDmNvSohl80fwMdmVErRy9YsJJG8fpPhdGXt+who
         H5AA==
X-Gm-Message-State: ABy/qLafds3LqS5/AY7Ipo2hfy4FnHRWyf2gzJkM4nc9DBZffKXLcL7G
        j0084mlMPfUG7FxVw/fmJqWussh6IWMSW+sEJXOv6jdPhALQQ0K6akqhyOCySzgIqX7yHG28Td/
        33ldlQ9mmOB8NDZ+/4Z5vfJfpHFRX3hw=
X-Received: by 2002:a05:6808:bd4:b0:38e:a824:27d3 with SMTP id o20-20020a0568080bd400b0038ea82427d3mr8268229oik.27.1688785330165;
        Fri, 07 Jul 2023 20:02:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/wIGcIh4mi8dj7CeWxGPQBKHnX7ZUocX7EB/QFAcrrPa55bOd1jPG2U1h7SX38JR7V/Rgow==
X-Received: by 2002:a05:6808:bd4:b0:38e:a824:27d3 with SMTP id o20-20020a0568080bd400b0038ea82427d3mr8268212oik.27.1688785329913;
        Fri, 07 Jul 2023 20:02:09 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79382000000b0066a31111ccdsm3431852pfe.65.2023.07.07.20.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 20:02:09 -0700 (PDT)
Date:   Sat, 8 Jul 2023 11:02:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] report: safely update the result.xml file
Message-ID: <20230708030205.zjavir3xuu7axgaw@zlang-mailbox>
References: <20230706204232.1577765-1-tytso@mit.edu>
 <20230707150130.GA11442@frogsfrogsfrogs>
 <20230707161747.efz7azf6jta4e27w@zlang-mailbox>
 <20230707191331.GA2653610@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707191331.GA2653610@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 07, 2023 at 03:13:31PM -0400, Theodore Ts'o wrote:
> On Sat, Jul 08, 2023 at 12:17:47AM +0800, Zorro Lang wrote:
> > > sync "$tmp_fn" && mv "$tmp_fn" "$out_fn"
> > 
> > I can help to add this when I merge it, if Ted doesn't want to change
> > more than that.
> 
> I'll be sending out v2 shortly.
> 
> > Just curious, will renameat2 ignore data still in cached? I never did things
> > likes "sync && mv" before, is there any known issue or it's as expected?
> 
> POSIX does not require rename() or renameat2() to do anything with any
> cached data.  All it does is make changes to the directory entries
> involved.   And that's what the VFS Layer does.
> 
> Some file systems implementation *may* do something special on a
> rename(2), but it's not required by any specification.  For example,
> in the wake of the O_PONIES controversy, ext4 will initiate (but not
> wait for) the file writeback of file being renamed *if* it is being
> renamed on top of another file, causing the destination inode to be
> unlinked and deleted if it doesn't have any other hard links to keep
> its reflink about 0.
> 
> This means that in the case of renaming result.xml.new on top of
> result.xml, if result.xml exists, this will trigger an immediate
> writeback of result.xml.new, instead of waiting for the 30 second
> writeback timer --- if this is happening on ext4.  We added this to
> ext4 because when people would exit the old Tuxracer game, this would
> rewrite the top ten file in an unsafe manner, and then close the
> OpenGL handle --- and on kernels with buggy proprietary graphics
> drivers, it would cause a kernel crash, causing the top-ten score file
> to be lost, and causing many users to complain to the file system
> developers (but curiously enough, not to the application/game
> developers).  So we added something which reduces the chances of this
> being an issue, but it's not something anyone should count upon.
> 
> As far as sync && mv, that's the shell script equivalent of what
> careful userspace programs should always do, which is to write the
> file to foo.new, then fsync it, and then rename foo.new to foo,
> optionally renaming foo to foo.old or foo~ beforehand.  Text editors
> have always gotten this right, because programmers get salty when
> their source files get trashed.  For whatever reason, desktop
> application and games tend not be as careful....

Thanks Ted, good to know that! Maybe we can have a "_mv" in common/rc does
"sync $1 && mv $1 $2".

Thanks,
Zorro

> 
> Cheers,
> 
> 						- Ted
> 

