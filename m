Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CBC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Mar 2022 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiCTRjx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Mar 2022 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTRjw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Mar 2022 13:39:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690D17E1A
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 10:38:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so19372wrc.13
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Wbz9aDlJsLgu3bcZJE6EzO1kVrhthP+UBKGpiY9DrQ8=;
        b=S2C4UoUk/pB34wSdYMPCavyqfFDzooLl9yE/NVYN0LSBvxQXdnfMsfWegRbo/Dyms0
         iTFJ7TZHDW+x8JYJd3WLUg4ailnf+SGko4NUCvBievYjvtwaTJDJxauvEXjy4zCB9ORi
         s8mAiFFB9SkQrFlaaDlKmTanB3lckAuDnLzT4jpaLfqcMo3+d4vtR9utHME4WPf0ZCZT
         51PN0HwaM2eTgGwZtJaZBx7ik+b89G3KVYk/1wxyl/WZB09fr9RjPOzxL1FI1zw7dTMZ
         gIYZDCQEPiK0w7Ya/1Hsi3jkrVy0xpj+JrkafPpSIAmGupRlHGCswVRjMhuVT5xLVi5i
         s7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wbz9aDlJsLgu3bcZJE6EzO1kVrhthP+UBKGpiY9DrQ8=;
        b=e68FIZBNmSS6c+3ti4HVK2GopxDoM8FE4PpjhCO/H4MoVR2OOgjkJEXH2E2Vd0nrrt
         Z3+uU5FQBHkI9XOMOUHfhHQELsLITWYDtxMKBiivosXuQ4D078Dpv6kUyt7pfls63p5N
         WKOJJuZXX69/papbvZV2s2tAzc12VEap1Dj7FTSPsFhKruJc3GMEHCe7/oqVMFAJQ87g
         VFkHgHhARyc3+UOpO5dQEft6Ha4yAXx+9fHBr2d2ZSgvnXYGw5+STFty9iCXUEieokYd
         vPeIXC2LLthb1GLwt2FABDUQgzcySMdM+SvUGb0Xwzu9FNeI1Cdt7TjOEkpMrfWYFvMX
         g5vg==
X-Gm-Message-State: AOAM532BQmH9Yc+tktg3i908s8UcdTnsS8SePSod6MAWeVfDJdN2j9bd
        7brDY3+j51SqDzHEQF3SWIlY6HdsLew=
X-Google-Smtp-Source: ABdhPJwmhTbdrZNCFVz/RP2ec1iOJD0T8ZBF570WxORR+yQCZmMuSJectSRm6yo/zSZYdKXekOyEBg==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr14696283wrn.454.1647797907091;
        Sun, 20 Mar 2022 10:38:27 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm11336471wrs.56.2022.03.20.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 10:38:26 -0700 (PDT)
Date:   Mon, 21 Mar 2022 01:38:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Amir Goldstein <amir73il@gmail.com>
Subject: maintainership of fstests
Message-ID: <Yjdmj0lVqCbbbjW8@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

It's almost 6 years since I've taken the maintainership of fstests, and
I tried my best to keep the pace of weekly update, or at least bi-weekly
update due to something like public holidays.

But it's been a month since last fstests update due to my personal
urgent issues, and some patches got no review for more than one month.
So I think it's time to re-consider the maintainership of fstests.

I will have less spare time in the foreseeable future, as I have to
spend more time on my family, so it's hard to keep the weekly update
pace. And six years is a long time, I think it's time to have a new
maintainer.

Or we could go to the group-maintain way? As Darrick mentioned before
(for xfs not fstests, if I recall correctly). Then we need a new primary
maintainer :)

What do you think?

Thanks,
Eryu

P.S.
I'll keep the maintainer role and do the review & update as usual until
all things settle down.
