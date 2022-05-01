Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB60C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  1 May 2022 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbiEAOcC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 May 2022 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347636AbiEAOb5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 May 2022 10:31:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1820BD7
        for <fstests@vger.kernel.org>; Sun,  1 May 2022 07:28:29 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 126so8879428qkm.4
        for <fstests@vger.kernel.org>; Sun, 01 May 2022 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pn8HkU7QQBVVwIjLYoARJB5iiMsFMcx8Bt/8i9MDqSc=;
        b=5ZTBzi3w2hHCYBjERi5vW1c2hk1MMXO5dWPq729fg1wHt/OX2cKmEA966FVmEYPK6b
         FNWY8NlCBVoGkd4wxNtfK+MyvmQAqHA3yXmYSWyjz1EKcBIkPMd6nK7IQauZ4FeaZrbb
         nexxwCAdh2er2Sj/x6N9zP7NrhSGHBxLnm0YIxle3p2UHc6RX1qJUzHl+wpUmALPEWBD
         2m59h/kGX1eekeDxYs8xxmBlJ+7vMbo+0/yQEKczr9Q7w2r6LmxWh1BHJwA9e3SdrDVI
         e4RIPi8EcwFuWv/VQZlj+VDcFUfpGeHhKBywJ8dDu2396xID2VXphfP0w/vCZyjT3Mea
         JdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pn8HkU7QQBVVwIjLYoARJB5iiMsFMcx8Bt/8i9MDqSc=;
        b=MS+gct6xKejsKb4m2VHDe3/Cz9rP95yLEtBqyHoeyoRlHNiqeoZZtZzhdp6IqhOX/9
         3AoJt72MmK01Xxxbz8pP+KwhJr1QAw64XDNd3d2EWs6Lq4yPU98kGUIJldAHOWP5L+jp
         +D18LbarFvlLw6DICCPGkVguX/zNdtx1Frs9TOvke3qQ0vhrmyhMmLnGRrXBKjJzk377
         04m+p6gp5rE3BfIGYizD/ArGJR5FN4dOB4qt38NMYL9O04GyImH2cnXfCIhxdAI5JD8D
         bhuM7bh34tWaxmUdQNvgjRQajp82hQWjqzlYtYBUKuELveeD9DhoczDGHD8tiLOWvGPI
         Ec1g==
X-Gm-Message-State: AOAM533DJy1yOcnI8+ExNFwe5PYly6uiMaMnaQjYkA1zYcnT0zUwE6Gj
        hF+TxP24BSaylWyE9sIa5toGgA==
X-Google-Smtp-Source: ABdhPJxBSumdv7NFEa/CbBiepXpJd8g+K0RKfcPzKAjlFNN5J4MDDjFemxzhbX38mcgSDqt9lajMXQ==
X-Received: by 2002:a05:620a:74b:b0:69b:db1d:f91e with SMTP id i11-20020a05620a074b00b0069bdb1df91emr5770863qki.286.1651415308350;
        Sun, 01 May 2022 07:28:28 -0700 (PDT)
Received: from localhost ([173.95.209.66])
        by smtp.gmail.com with ESMTPSA id q77-20020a37a750000000b0069fc13ce1fcsm2840637qke.45.2022.05.01.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 07:28:27 -0700 (PDT)
Date:   Sun, 1 May 2022 10:28:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v9 2/5] common/verity: support btrfs in generic fsverity
 tests
Message-ID: <Ym6ZC8Ag2KEiJheZ@localhost.localdomain>
References: <cover.1651012461.git.boris@bur.io>
 <3ac2f088ab31052659aa37a7e2f0821ef7b95e60.1651012461.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac2f088ab31052659aa37a7e2f0821ef7b95e60.1651012461.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 03:40:13PM -0700, Boris Burkov wrote:
> generic/572-579 have tests for fsverity. Now that btrfs supports
> fsverity, make these tests function as well. For a majority of the tests
> that pass, simply adding the case to mkfs a btrfs filesystem with no
> extra options is sufficient.
> 
> However, generic/574 has tests for corrupting the merkle tree itself.
> Since btrfs uses a different scheme from ext4 and f2fs for storing this
> data, the existing logic for corrupting it doesn't work out of the box.
> Adapt it to properly corrupt btrfs merkle items.
> 
> 576 does not run because btrfs does not support transparent encryption.
> 
> This test relies on the btrfs implementation of fsverity in the patch:
> btrfs: initial fsverity support
> 
> and on btrfs-corrupt-block for corruption in the patches titled:
> btrfs-progs: corrupt generic item data with btrfs-corrupt-block
> btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
