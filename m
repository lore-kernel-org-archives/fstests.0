Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E7EB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFUVhS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjFUVhQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2023 17:37:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C51BF4
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 14:36:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b4f9583404so49168365ad.2
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1687383375; x=1689975375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBMqFTsYTJ6cqyNHE0bmKqwPwK0uftwv+rRWsIsZyTc=;
        b=RxnUWvKwL7Z8Pm/76LYrMz4Z4axg0Q04ifl3JafoXqIFHnc8HD/4C7h9Eoai8D0Yef
         Pu25MwHtu56sAO/EXc36p0OHSnWFbs9ke8rczQGXNskpUzETTfEJsh//7veoS2fe/9Bz
         p9h9oZoCvVHknANlqcDnChBpBw2qa2/I8ctBXi6XcgxQCXcZVD9l4ME5G7fVLmTRaMtB
         46ySLj9czoYlMvdhKMczwrpCaxfv6muDsJuDkN2x0pG7BEZPidA6smUd7Out2oNO6vgs
         ccTp/7W22lBz/sG9RLTfWdluF4AUQvmiZIB+jkseTpjRDzBLGBig3jt13WgaU3Q34irM
         V82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383375; x=1689975375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBMqFTsYTJ6cqyNHE0bmKqwPwK0uftwv+rRWsIsZyTc=;
        b=IVmq5obNVw60NYyz3QJhQTpxKcMkDLcGwBbz51V82GmSEIDA1UzoJV2beUXikhudT6
         StHLU7LxEDESlTbLRQoI4+03hkDuw83Ag33oXNxaUyMMimjAdOE9Ddl1tEvwEngKDl8x
         LgC3F9gN8YgFLV+tqce8+UBqQCZ7jiu1B0oRLZQSjQmVmSRYAEQj0XrgXTZw44bQxHIC
         CbKhOSpPDqqOITMsM/PllDkEo1f90VwQZXJdCz3iE3N+vMGn2Drn4G+FaYNo4xgF0XXN
         E1QVRyDuqBPFva6pUt3hdPR+oCs1QeTAF18SOBE7039lvkt9ihWoO03n0Z8F4YrIt1/0
         7lXA==
X-Gm-Message-State: AC+VfDxs++fJqE5hLLlgcL9ebVeZL2Z3R68of+38Q7chEm5++zgmNbmq
        GS45fJL7Nj+VFznJfpbqBiKFVA==
X-Google-Smtp-Source: ACHHUZ7l4dpiCy2HZ1YMT0mnDlHZBOSgAwCwjusBDU1t6v7hxYCsZneLNAxtlqvR28LEFtQ/gkBQrA==
X-Received: by 2002:a17:902:efca:b0:1b5:1573:7d96 with SMTP id ja10-20020a170902efca00b001b515737d96mr15543504plb.59.1687383375228;
        Wed, 21 Jun 2023 14:36:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2:df8c])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001b539640aa3sm3918141plb.283.2023.06.21.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:36:14 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:36:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test activating swapfile in the presence of
 snapshots
Message-ID: <20230621213613.GA13893@localhost.localdomain>
References: <5417083e8e23a1553f428608d02a07aae21b9e53.1687262391.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5417083e8e23a1553f428608d02a07aae21b9e53.1687262391.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 20, 2023 at 01:00:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have a subvolume with a non-active swap file, we can not
> activate it if there are any snapshots. Also test that after all the
> snapshots are removed, we will be able to activate the swapfile.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
