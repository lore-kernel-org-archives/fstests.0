Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED36EB64DA
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Jul 2023 04:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGHEbm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 8 Jul 2023 00:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEbl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 8 Jul 2023 00:31:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129641FE0
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 21:31:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-224.bstnma.fios.verizon.net [108.26.156.224])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3684VKT9026213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 00:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688790682; bh=c9LQijeuZzV30YK2gYmxzbTy4j2kF6hBWLtzIDlb584=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YFxxtx/2v08/Sk5K8ohhIE17cZOR+9eLDPSRKpmDBPXO41QsFxH4RFfXlL5eMgpUq
         JuF8XxpPPfjyLcISKbOrzMqUD8uE3MpkKvpaIfywbx4Irfoi+TYmQgD7JCfE+w2F1Q
         uzsdIhnB/65Uob/oP4DsHcY67evJpzkziRErValtiv/lqKjOnXf3sdz9N9BFuvzYsn
         5b5WQlMCODrr8Q4hZLrl8jPdTFjrxPYtIJs9SNqJHGeVGjFep9tgfyItXoxwh9Gkeu
         tgC3f9/OZjMpG6pALbJIQDi5GXdhgN1qgUbQAaaJKaQHhbP1fULoXAxgXLua3JlGkz
         7r1Prs0KE0giQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 27D7E15C027F; Sat,  8 Jul 2023 00:31:20 -0400 (EDT)
Date:   Sat, 8 Jul 2023 00:31:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] report: safely update the result.xml file
Message-ID: <20230708043120.GN1178919@mit.edu>
References: <20230706204232.1577765-1-tytso@mit.edu>
 <20230707150130.GA11442@frogsfrogsfrogs>
 <20230707161747.efz7azf6jta4e27w@zlang-mailbox>
 <20230707191331.GA2653610@mit.edu>
 <20230708030205.zjavir3xuu7axgaw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708030205.zjavir3xuu7axgaw@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jul 08, 2023 at 11:02:05AM +0800, Zorro Lang wrote:
>
> Thanks Ted, good to know that! Maybe we can have a "_mv" in common/rc does
> "sync $1 && mv $1 $2".

Perhaps, although I can't think of any other place in xfstests were we
are actively (and repeatedly) renaming one file on top of another one,
or rewriting a file in place.

There are certainly places where we use "sed -i" to rewrite a file in
place, and it does do write the file to a new file, and then renames
it to the original file's name (yay!), although it doesn't do an fsync
before the rename (boo!).  That's arguably a bug report we should send
to the maintainer of the sed package.

						- Ted
