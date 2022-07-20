Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEAC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 14:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiGTOOB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTOOA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 10:14:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C84D16A
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 07:13:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a9so13366635qtw.10
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2paShj/WbCID2vVVBGSDwJweFW9y6tZT6y1FyYfDR78=;
        b=pnRZdg0o/aDh+EtWwCpkGiL7AOC/jK+KYRWd1+UcNYrR7mUvNFbCksK3TWzkAVXiZ1
         ZSAS83huODYKeyQw31IIZKB6IH9vk+dM7Vcbczi7QTVFb7lBLJ0I75wjucCfJREMRJcA
         0tWWivQY39JdoEcKDH7ulZxAYpo98iUBm7uxcTlgz6wKCoWho7a9jUXo2iclLpqCcPU4
         0ECRJXQ1nArcHpuiMX7f4KKvla7AhhmdgWVzhmfFOmaYZWSXO3YbbWbNOGinYUALIft1
         Q4+QTCTut8nDIzETy+hxpvl2IFil14U/Ip79i9AJnhIuCLcuxRa7olu3JZ+CXVAOiIUt
         HEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2paShj/WbCID2vVVBGSDwJweFW9y6tZT6y1FyYfDR78=;
        b=IxvzG3Ef7iGO8UnvLmTiv0K+e4InX5evuc00Dpu9viDRD4vIZPoclY9wKrXMDiedH8
         5aRJ7mNKMM9ssWRXfjBHrzGHgqcw+3Z6RLPhDxmr73/W7WGEFJmtw+l3rhX83V59OhgE
         dyTtCt0D54rLr4fc48t0O5E5PnKTjLFerX456vy8bi40jtb/dSKexZiE/wriRucwBWGQ
         XDjPN06HSSGYGxcVh4hqwKz9jR4+AmlqI0Ie2VTWW0o5ZFozyjpYtoeremmpv0ozug2e
         bdraEGDA7+/Pkx3z/CrkoT/Q9SAZfnM8MhprqmH2y1bzy/6u7xyq9LF3P7xTqpiuOWEF
         YSfg==
X-Gm-Message-State: AJIora8zjfLNqprbWHu7TL8fjoDhAv684OBqwJXW9PPYZ4aWw0tq5FkA
        azjWQFHpxGaQjLDpH5n6J2g3mg==
X-Google-Smtp-Source: AGRyM1tr7DPMNFgBzMX6CveG8RFSQi0ZOUGnW9e7h+aVWfeZzv5Zphsp0FHq50T8/XQrrFIYvuDh/Q==
X-Received: by 2002:ac8:5b0e:0:b0:31d:3b3d:37cd with SMTP id m14-20020ac85b0e000000b0031d3b3d37cdmr29680008qtw.657.1658326438269;
        Wed, 20 Jul 2022 07:13:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006b5fe4c333fsm4174482qkb.85.2022.07.20.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:13:57 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:13:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 0/5] tests for btrfs fsverity
Message-ID: <YtgNpAa8qu4LOSyP@localhost.localdomain>
References: <cover.1658277755.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658277755.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 19, 2022 at 05:49:45PM -0700, Boris Burkov wrote:
> This patchset provides tests for fsverity support in btrfs.
> 
> It includes modifications for generic tests to pass with btrfs as well
> as new tests.
>

These ran fine on our overnight CI testing, the patches look good as well, you
can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 
