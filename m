Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D491C38147
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Jan 2023 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjARQIN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjARQHq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2023 11:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC553E7C
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 08:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6IqmmpZ9I4Vl93/dhw5LrxVGVOKyZqjXYxYco0sdHY=;
        b=H09y4Dnpptqqw/+ihbU7UyzvTiQGlZbjIgb7D1Woq2hUuLX+solMhXWC8NUkXY4LEQyBIX
        il3xWkhvz67SzPbDtjt7rLekw4D8NfOw2XQQfkefySC9clluk2QyQHe4zWWdjNMZfh1H0W
        cFh3EDeNqhMbnEdi1QrHSO4LOhm+Nvc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-gVm00nLNPMKtFSbLWdi2Nw-1; Wed, 18 Jan 2023 11:03:35 -0500
X-MC-Unique: gVm00nLNPMKtFSbLWdi2Nw-1
Received: by mail-pj1-f72.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so1682360pjb.8
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 08:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6IqmmpZ9I4Vl93/dhw5LrxVGVOKyZqjXYxYco0sdHY=;
        b=HzMSLJ8TfB6A1DH44gj1FCxCfOwtUnazrske9RJnRWhq2AsGaGXlxKCMngRPHKLaQF
         g5Xe9UQz8xin0wn1053tkv3FRC3fzEXB2gV3I+TiiFRKb97ktndpnyLAejLZ27gxJ70m
         c8ZIX0t78l0J0ND0IwZJe+7xnyP8tnQrP9x9zrhsNk0xxWpNyQ0qiakzr/7oxLiTqI4U
         QRqiAfWI2Dpv8SQOGvqM0CWtne/aGTalgt3kKVTWap5SOyCpkNJ2x/2q48vWn9xoBs6Q
         HAGye8Tp3D8FHbpTuWP7o+nbLlu9EmXnx3rHU4jqaC9Ny+/mEXXHFmp2syRV6cj99JDL
         e1hQ==
X-Gm-Message-State: AFqh2kqigh6EDKgb9tsNNEjR+F9ZGoF6qu9glF998W+251MzllVcRRRk
        873r5d8OEc+MBIMUcnHnRVmdmMyiAhkux55MKjr+8TeCds3sIcitNk4pjwrwqbRX8n62jyDl8Tn
        iDoRKvH2j6FGPbao77w==
X-Received: by 2002:a05:6a00:4c85:b0:58d:dfb1:8023 with SMTP id eb5-20020a056a004c8500b0058ddfb18023mr5001060pfb.15.1674057813885;
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs471cXGsAqsTBhZmYbNrPuvtIJQ9qUHn3BExn6sNE+TJfwyf6NmyB9vzFYeYsjUo7hyWa/bQ==
X-Received: by 2002:a05:6a00:4c85:b0:58d:dfb1:8023 with SMTP id eb5-20020a056a004c8500b0058ddfb18023mr5001043pfb.15.1674057813641;
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w4-20020aa79544000000b0058db5d4b391sm5307916pfq.19.2023.01.18.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:03:33 -0800 (PST)
Date:   Thu, 19 Jan 2023 00:03:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Add default commit interval test
Message-ID: <20230118160328.qusc5f7h6iwy6tbj@zlang-mailbox>
References: <20230118052515.3966391-1-wangjianjian3@huawei.com>
 <f6b28fd3-1f36-2bb0-aadd-d08b81a64835@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b28fd3-1f36-2bb0-aadd-d08b81a64835@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 18, 2023 at 01:27:05PM +0800, wangjianjian (C) wrote:
> Ignore, sorry for the traffic...

Do you mean ignore those redundant patches, or ignore this change itself?

> 

