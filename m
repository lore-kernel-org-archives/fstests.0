Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2FC004C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Oct 2023 15:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjJWPKm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Oct 2023 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWPKl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Oct 2023 11:10:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88277DD
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 08:10:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7ad24b3aaso35508527b3.2
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698073834; x=1698678634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT/yC7uPar1/8Ex9cQ/S9J2X1+tzCHBSayZxtj5rwtA=;
        b=MIRx6ljctdb8qNL07hygsY0rbSN7FJ7w2pQLJ9OxdaKMi1eFnEN0oHyNlxZNa8aMoF
         VL8j6ykHyTV9Qsbxk2WH9jOdcseTr8ygh71swZfXsHquQbhW63UqyI+Beo7vqLYVfGgc
         OLDEltJUL6ks7xybmgbLZEEF5ntOW/ctWNsjz5lPUe6VeNKLQ42TqhfpdsGb0PBeDmt9
         0AaYK7nBDw3CH6yj2nBcxj9Mmxwmgp47WDfwy/tQvGzm2TtoIPGgrX7IY8EsRgs7P7w3
         7dq12MIKdC84HRIAelzHf+nQPYNOsfqu0JRclR/UgWHzdoY+yHWy15yEdU1NK3IQho3V
         9TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073834; x=1698678634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT/yC7uPar1/8Ex9cQ/S9J2X1+tzCHBSayZxtj5rwtA=;
        b=uLCTn2lxoWWZRzjY2EQOityy/4dgaJy30qRVHqyV4VdcCjfjAvc0fBxjL0SqsK8ppp
         gQPSRJbhYejIkIQzZUMEsp6tbrvigd8rAWutHHM2/Y0kWMN8sBGx3UY0L8sGzLmGuPvK
         XueLK/uCO3ESbArfvW5Hh3uZrmjKpMOIWXAF0kidA0E659RA5BjvO42jVgSOAkYB8JjG
         nmd3O7e0lsNgiRNC2EC0hcbdFDw3PePnlh7jEEUsZ+HvC0o0CbX9tTYhZOJO8Ib96ZNs
         lvlq8Et97E4besXXLGoklqdyYamRHpvzwYs4vc5QpirS7FuCCawOeO/v/4gn5WEEh2tw
         mJRw==
X-Gm-Message-State: AOJu0YyIRUUk/c9G+UXcOzBkzSVm6bRu4HLdiHOTru5EbqomVt6p5X48
        aqzTwZSzplfRRM2uAVm2r9LegJ0gmMdWwmQURrO1dg==
X-Google-Smtp-Source: AGHT+IFikmGkJ7Nzuv7LRFMijQJRvhXqDUCUJXPVUuEPr4RZpR/9XtNJFAPFSsvg+ch/pYzgZToz+Q==
X-Received: by 2002:a0d:e347:0:b0:5a8:1d75:65c3 with SMTP id m68-20020a0de347000000b005a81d7565c3mr10397114ywe.13.1698073833709;
        Mon, 23 Oct 2023 08:10:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d5-20020a0ddb05000000b005a80102fe3bsm3227059ywe.13.2023.10.23.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:10:33 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:10:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test snapshoting a subvolume that was just created
Message-ID: <20231023151031.GA2798160@perftesting>
References: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 19, 2023 at 01:23:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that snapshoting a new subvolume (created in the current transaction)
> that has a btree with a height > 1, works and does not result in a fs
> corruption.
> 
> This exercises a regression introduced in kernel 6.5 by the kernel commit:
> 
>   1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
