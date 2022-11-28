Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691EFC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Nov 2022 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiK1QDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiK1QDL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2022 11:03:11 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A21116B
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:03:10 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k4so7552395qkj.8
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=menkDLFTK0ucehS7YUSqDx7q0Zc1/XhysGCjN3/Cgds=;
        b=vDwdH37/bVP2DKYQVvvp7f0ZEt/89cChNNSrOSioM7LU4HaF9oTUh4qYTWwKBWAxyu
         rn08kOmHR2SDfmCi6jmeUkyANAItF38qyiFqehslm4380CCLLtOFNnTOO4ONLGmwPw3V
         BZEFsL03oVuvZu4omaWouk9sNydlH59XYf7Rbi7kWANmQ6im/Lr72+xRaYs7e3ONVR2T
         Fkvw/Lv6S6f5ehSuViIl30oqgmm/sLJsw4vLLYpYzn+gdxHS+XDM0H5MqKed0U9h1WkQ
         Huoobe1f2WJZSPILcjQXFOxhSbMC6Ox4Q58msydjnCTax96i+9tg+U1fmGZ7necjFgb8
         nhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=menkDLFTK0ucehS7YUSqDx7q0Zc1/XhysGCjN3/Cgds=;
        b=jPde/cijpNPAlnL84biqcG9KmHxPryU5e1ZXHdejSgQJ91hdG/PjYAJVJXoAj78i1E
         XF+SZhjJziXuZaWVgwx2UFF0kJSgW2YjL4UOZiMiJtLB1Q/DQHjiG+AqFij/VM2bmcWg
         SuEXwh9gEQH22Edg655gv94EhtCMTmCLA9T5Y8NzYWzN/y6Xzov9QRDAjuzhqMuA25B6
         lQCZ+heTn8VN7jjVVbSZcNPHm36/0B6H3LMl+WJgq4SrJFy0UuU8cNi+tdCtzYPIMnoD
         3kw5V+rXfeZYOFF7KT0ZpinHEY6YdXC2ksw4QmW5WCdP3d2blS/2dD4P2OGJ3LX1rrFA
         lnGA==
X-Gm-Message-State: ANoB5pltcyAefYkOOlLayZwAIC7mbtVyPbWgCSDgshXAaL3wrsjDNkEc
        nDlm5/+Yjv5/04FxhOwfk8LH2Q==
X-Google-Smtp-Source: AA0mqf4dMJmokOLhQEcXE69ImmSdhVnsKgVgdDNuyJDW+oh4VXWIqieB3SxbCCr+boRU8hdUiB0O8g==
X-Received: by 2002:a37:ad0a:0:b0:6fa:2c9a:ae20 with SMTP id f10-20020a37ad0a000000b006fa2c9aae20mr33658449qkm.582.1669651389359;
        Mon, 28 Nov 2022 08:03:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05622a228e00b003a51e6b6c95sm7066401qtb.14.2022.11.28.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:03:08 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:03:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: skip btrfs/254 in case MIN_FSSIZE is more than
 1G
Message-ID: <Y4Tbu6YMaiN03Bi6@localhost.localdomain>
References: <20221128125105.52458-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128125105.52458-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 28, 2022 at 04:51:05AM -0800, Johannes Thumshirn wrote:
> The test-case btrfs/254 creates a 1G device-mapper setup, but this might
> be too small for the filesystem to actually operate (i.e. in case of a
> zoned block device which needs at least 5 zones).
> 
> Skip the test if MIN_FSSIZE is set to a value above 1G.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
