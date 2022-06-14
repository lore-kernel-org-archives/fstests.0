Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B140CC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 09:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354278AbiFNJYn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiFNJYc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 05:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CBB648398
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655198586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wL500kuZofPLhlgg9MWpmsN25gKPcsSWCkD4qrvFYPQ=;
        b=jPprYa4MyTOlbANiIRL6AjDKlZ5hr2Gr4PiO1g4kDOl7Oe6R62Lc4QrAChudpLKKHLqpy9
        r0JuDDl/v/8LtImizFPRzSswHHmd13pAlPFNDxu39KmG26iObpuxjtkpsZq/LU/Ane/ic+
        T8/YkF6kb7mKC2/NNXAECng66tDqfiM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-98aJm94HOHO1cBcRPAy4WQ-1; Tue, 14 Jun 2022 05:23:03 -0400
X-MC-Unique: 98aJm94HOHO1cBcRPAy4WQ-1
Received: by mail-pg1-f197.google.com with SMTP id y63-20020a638a42000000b003fd47b6f280so4767784pgd.12
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wL500kuZofPLhlgg9MWpmsN25gKPcsSWCkD4qrvFYPQ=;
        b=tXLg4xIoDohtRTNMGJ0pn/arBxLiaQ6Bxmu/4SI6DT6kxRTaiz17fqwEDKxEBzyWi3
         UsUHumozW3mXaGrFldS/GutT1/9ppUP6Mu4QSMJ4H39uPsB/f4rX8WIatJq2uH5dLUi5
         Wmfjep7i4OgL+vm1V4UtZ178plNNPr5vNOCzvs62iaxmuUL9T6QYl55xaeEYjKe5jgfb
         pnRSoi1ehhq3woOV3LfdgfyS+JC8ese/Y3ly3todMe8ehdAy73Pjn+kKs1ZdnJvsfslg
         72fu29ikcK4WKb+3hiaP379n0Wv6K2iy5Q+rmAKzGOxrs4rumrUC45Lxm4WrRbqvqnlv
         2JAA==
X-Gm-Message-State: AOAM532rYhn05t2urujzQCeK6t0p2anLrR9lTUR5ISkM+BOPO1FcJqX7
        pXT0bXSznrU3Ry7eib6H/o7Uxy7fn2ts76g8rNNvNgr1BfLGQ9iCYBWvXomQCTgeSqo4yi4vm1J
        W2QYPdGN+EqRudsnh7A==
X-Received: by 2002:a63:1d46:0:b0:3fd:df71:dac0 with SMTP id d6-20020a631d46000000b003fddf71dac0mr3735053pgm.258.1655198581871;
        Tue, 14 Jun 2022 02:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcGgH+akAFo0vy21bwAxO7etCG+oDCVa+C3+GEbh6r+OW4jesY61jKu90/RhECEgkZdqTjPQ==
X-Received: by 2002:a63:1d46:0:b0:3fd:df71:dac0 with SMTP id d6-20020a631d46000000b003fddf71dac0mr3735043pgm.258.1655198581584;
        Tue, 14 Jun 2022 02:23:01 -0700 (PDT)
Received: from [10.72.12.99] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b0051bce5dc754sm6990536pfg.194.2022.06.14.02.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:23:00 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Two xattrs-related fixes for ceph
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20220613113142.4338-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e41f28f7-fbd0-e861-603f-0813b91fe3ed@redhat.com>
Date:   Tue, 14 Jun 2022 17:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220613113142.4338-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 6/13/22 7:31 PM, Luís Henriques wrote:
> Hi!
>
> A bug fix in ceph has made some changes in the way xattr limits are
> enforced on the client side.  This requires some fixes on tests
> generic/020 and generic/486.
>
> * Changes since v2:
>
>    - patch 0001:
>      Add logic to compute the *real* maximum.  Kudos to David Disseldorp
>      for providing the right incantation to do the maths.  Also split
>      _attr_get_max() in two, so that they can be invoked from different
>      places in the test script.
>
>    - patch 002:
>      attr_replace_test now has an extra param as suggested by Dave Chinner,
>      and added fs-specific logic to the script.  No need to have an exact
>      maximum in this test, a big-enough value suffices.
>
> * Changes since v1:
>
>    - patch 0001:
>      Set the max size for xattrs values to a 65000, so that it is close to
>      the maximum, but still able to accommodate any pre-existing xattr
>
>    - patch 0002:
>      Same thing as patch 0001, but in a more precise way: actually take
>      into account the exact sizes for name+value of a pre-existing xattr.
>
> Luís Henriques (2):
>    generic/020: adjust max_attrval_size for ceph
>    generic/486: adjust the max xattr size
>
>   src/attr_replace_test.c | 30 ++++++++++++++++++++++++++----
>   tests/generic/020       | 33 +++++++++++++++++++++++++--------
>   tests/generic/486       | 11 ++++++++++-
>   3 files changed, 61 insertions(+), 13 deletions(-)
>
This series looks good to me.

Reviewed-by: Xiubo Li <xiubli@redhat.com>


