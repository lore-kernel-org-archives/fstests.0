Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B174C00528
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjG0Ujx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Ujw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 16:39:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150D2D45
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 13:39:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36RKdhhH009029
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690490385; bh=A3xh+foIt7qh81Oaj1XP91Kc8gHVVorsKhWghPCk99E=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Z+7owqEkQ58oztF6r7rPvvsRjgeS/8gJwv0PJfABffKWWNZTFFAETREy6K+Kb0CSv
         eRuOF/Dj0VqsMG5dqQ6V4qjegOlzkTvReCc45t6+W2rH3X72svudBatD6dALYvf7r6
         PELcsHt1Z2rm2PZNVaCNwabJjxfT2Yogy8ChNpmmyCsjVRP1nExokJpcjLz/geISE2
         7+qJnBx21qKY/EQQPmQQipiPMICi6Eesr2AOd2vVRi6oTi3+cx5DwopykXQWRtJxDd
         k7uodvIWDFNzY+yOv+QIg1xCRnLiwMgkJBKd/OhqMYTKDhBFWBQwde1jYLCtTLGzed
         TJO4Oq3V82Ghw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C15DB15C04EF; Thu, 27 Jul 2023 16:39:43 -0400 (EDT)
Date:   Thu, 27 Jul 2023 16:39:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fstests: install soak_duration.awk
Message-ID: <20230727203943.GA358316@mit.edu>
References: <20230727190512.357064-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727190512.357064-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 27, 2023 at 03:05:12PM -0400, Theodore Ts'o wrote:
> Commit 3e85dd4fe423 ("misc: add duration for long soak tests") added a
> helper executable, soak_duration.awk, is which used by the check
> script if SOAK_DURATION is set.  This script translates a
> "human-firendly" time duration specifier, such as 4m or 2d into an

s/firendly/friendly/

> integer number of seconds.  We need to make sure that this script is
> installed or the checks script will bomb out of SOAK_DURATION is set

s/checks/check/

> (and the fstests installation doesn't include a full set of fstests
> source, but just those files installed by "make install").

s/and/and if/

Apologies for the typos in the commit description.

					- Ted
