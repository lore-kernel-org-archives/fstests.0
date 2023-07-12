Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF4EB64D9
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 14:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGLOxB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLOxB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 10:53:01 -0400
X-Greylist: delayed 49394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 07:52:59 PDT
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6B7BB
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 07:52:59 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689173577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynluCSk/jkRBCa96gvtd77wcB34HpFEZyUObUk9zByo=;
        b=aNAR2iD5kAZ7pNZJ3/7G9mPyDYc6GTFFcl0DTl1rP8QGSDzZyW4/8MXm+ncpEudg3xRBOZ
        qiuckHFK39HLBr5VQUYZpwiQ5qw6rT66kL+7R/+9rFrQZdoYOAO4fxldcpggSvLKdpcLkz
        286/qXrsNOvpVfCtCcbLl6WWUTYIUJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230712145252.35xgebxg4i4a6g7e@moria.home.lan>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230711234439.GC11442@frogsfrogsfrogs>
 <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
 <758f1d7d-2411-848f-6773-b8873d8dce83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758f1d7d-2411-848f-6773-b8873d8dce83@redhat.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 12:10:05PM +0200, Mikulas Patocka wrote:
> If we hit the limit of total open files, we already killed the system. At 
> this point the user can't execute any program because executing a programs 
> requires opening files.
> 
> I think that it is possible to setup cgroups so that a process inside a 
> cgroup can't kill the machine by exhausting resources. But distributions 
> don't do it. And they don't do it for a root user (the test runs under 
> root).

When I looked at this test before I missed the fork bomb aspect - was
just looking at the crazy numbers of pinned inodes (which is still a
significant fraction of system memory, looking again...)

If we change bcachefs to not report a maximum number of inodes, might
that be more in line with other filesystems? Or is it really just
because bcachefs inodes are tiny?
