Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CADAC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Feb 2022 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiBVKic (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBVKib (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Feb 2022 05:38:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ED2148931
        for <fstests@vger.kernel.org>; Tue, 22 Feb 2022 02:38:05 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 885D821117;
        Tue, 22 Feb 2022 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645526284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtDxVv37uxGwBGxY0+IkJefz1uW3cHnt/RqW/D8QhVo=;
        b=XB3d+7hPgfbnjcW+0jdTTNFKzcq8+uBBjzrRSODfXYFU55kIVYUHnYX4R100sokr2nnPZT
        DfzNkJTHiIqfGOmFz1s9Xyn9eRLPheUP9HV6EGmjiOMzwg7bzTEtmZcVBYhAf4JOE3GtBr
        z7L4akHthp7bKcdpwKieWl0lN1fVzUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645526284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtDxVv37uxGwBGxY0+IkJefz1uW3cHnt/RqW/D8QhVo=;
        b=eCE9Hc/ynOEu25MoCJjNvWr/PPiHhTkcu37GspW5b1WcUZUEiyhhVFxRD0rvsdVz53ZZDp
        zgG3hzlxFGZsJvBw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7D5A4A3B81;
        Tue, 22 Feb 2022 10:38:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4D322A0606; Tue, 22 Feb 2022 11:38:04 +0100 (CET)
Date:   Tue, 22 Feb 2022 11:38:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/673: Add test for seekdir
Message-ID: <20220222103804.4a7uhuzibhu5x7md@quack3.lan>
References: <20220204175657.8500-1-jack@suse.cz>
 <YhJxGmyHga4zc6ZH@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhJxGmyHga4zc6ZH@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon 21-02-22 00:49:30, Eryu Guan wrote:
> On Fri, Feb 04, 2022 at 06:56:57PM +0100, Jan Kara wrote:
> > diff --git a/tests/generic/673 b/tests/generic/673
> > new file mode 100755
> > index 000000000000..f6dea54db1a6
> > --- /dev/null
> > +++ b/tests/generic/673
> > @@ -0,0 +1,41 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 YOUR NAME HERE.  All Rights Reserved.
> 
> I forgot this in my first email, "YOUR NAME HERE" should be updated
> accordingly as well.

Thanks for review! Updated version sent (just forgot to add v2 to the
subject).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
