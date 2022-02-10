Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6261C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Feb 2022 09:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiBJJo3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:44:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiBJJo1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Feb 2022 04:44:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6411A7
        for <fstests@vger.kernel.org>; Thu, 10 Feb 2022 01:44:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6551E21115;
        Thu, 10 Feb 2022 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644486267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZDW2KO3KlHZeJHcinhfxi5llxVHeLurRBqjji6YcGs=;
        b=JCUcnidQqvE4NChxrYZDebCazifozaJcnzrJodkR3jybun5mu1n9dD9cgJdZKfCAlgIgda
        0mux7AHLMhUChBneynT/mgXYY0iClQ7DvsFamLHW6bJwd+tF98vIEWINOCDVng4s/JNXMb
        Fkp3RY9CE0KJhfGg2W8cpe1/7MMD8CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644486267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZDW2KO3KlHZeJHcinhfxi5llxVHeLurRBqjji6YcGs=;
        b=Is33JS4qGiQX9Yqm/b80SaN6cudXnFvQGNE9oRe7OhtZk/GvOoEcSX/932EuC/7qjKmbqm
        D7/e/r6bXME6TuBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E0D8DA3B8C;
        Thu, 10 Feb 2022 09:44:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96EEAA05BC; Thu, 10 Feb 2022 10:44:26 +0100 (CET)
Date:   Thu, 10 Feb 2022 10:44:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     raymond.barbiero.dev@gmail.com, fstests@vger.kernel.org,
        jack@suse.cz, mgorman@techsingularity.net, dave@stgolabs.net
Subject: Re: [PATCH 0/4] dbench: few enhancements from mmtests
Message-ID: <20220210094426.wbm2malmzvkxq4j6@quack3.lan>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed 09-02-22 14:18:45, Luis Chamberlain wrote:
> mmtests [0] also uses dbench, and they actually carry 4 patch delta
> for years. These patches are useful and should not interfere
> with existing uses, so just merge these.
> 
> As noted before, I've put all this and a few of my own fixes
> into my own git tree [1] and I'll be extending dbench there as well
> as I see its not up to date and even debian has dropped packaging
> it as it doesn't compile anymore. The one on my tree compiles more
> than fine now. I'll send a few other fixes after this set.
> 
> Mel, feel free to drop those patches if you want to use my tree :)
> 
> For lack of a mailing list for dbench, I'm freeloading off of fstests
> as it uses dbench as well.

Cool that someone started maintaining dbench ;). Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
