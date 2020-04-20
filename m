Return-Path: <SRS0=ARln=6E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDBCC54FCC
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 22:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFA920672
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 22:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI78ubZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgDTWjP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWjO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Apr 2020 18:39:14 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98591C061A0C
        for <fstests@vger.kernel.org>; Mon, 20 Apr 2020 15:39:14 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z12so11591150ilb.10
        for <fstests@vger.kernel.org>; Mon, 20 Apr 2020 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GsEGQYhQMZvYnRPfAck5zmHt/9Kx4Q6IuQ0U+l5QLqE=;
        b=LI78ubZ3FxXR5FFc52jJbDoQp6+phZp9Qc0GAZ1QZJpML53e3ovhv2sAZ6nYI0+0uL
         TAX84AD31dr6V9pwKLLt5PFJ62rqJSZOst50inDFdUmQIPTrUZDzEjiMuaPEbxa+ca/1
         yAzMrnyRDLugeBjAOI5ppgEpmPF06B2kBEJ4+TCXl/Lk0Uo7uuMAHTpeOByPcuvUVJJq
         2Kq4jaBLf3a38JfdOr//gDFRnR8hQ3J7kwHdggYV0JGw0X+2FB5FtmhMQxmrloY8JDkB
         xUJvlm2cqfKN0SqQx+SsmDhjmruWfst4PDzv6inQvSgM/KNdtqMiEOYcWHLkTS3yviE8
         SuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GsEGQYhQMZvYnRPfAck5zmHt/9Kx4Q6IuQ0U+l5QLqE=;
        b=OKuMZJSCmm27Wwe6fJW6IuweLgAY+nMEspdCMOUPMNlt1HA1bP50qG2/amatZWbMp7
         a4+FyOtYNoEHxI96P8A2A59FBJZAEZsxgk0y7ZkGaSV/7/vUKUM5knJOMHFFfCogrcbp
         nArVFgkxGuBAgjh3P/e5hC+FsgaZhErK+zvj2q/3HGzHncyHaQlAEeg1KCOCUXnxlUVD
         DenGtXG++hzzyr+F3tYzPaf9VUEMy1e448MImWBSaSuyTWi50S9v/wINakqAAs7ZhdHP
         CDjPw7qWk5S7A+nNFK9JMRFP4AsVjHgD0qR+1X9HqQmaL8z/EVaLkwkZroWX1rcDbUY7
         bhpA==
X-Gm-Message-State: AGi0PuZ+IuWhIl6DEg05b+BomSpq/OEOF6hG9Jb4zms2KCrgHnS35no/
        glCX+nolnxi9r4qSM5Z3DxMiuvOTeynZTSwBCmxlRWv6iw==
X-Google-Smtp-Source: APiQypIsAroiUPfnT7Amcq7r7F7wpCQZ9DtM5BQE3bu9DFBbMN5+E7APsIf1oal56C6n52dIeLlCy9Z2i2/w3Q07G2o=
X-Received: by 2002:a92:984d:: with SMTP id l74mr18232286ili.195.1587422353593;
 Mon, 20 Apr 2020 15:39:13 -0700 (PDT)
MIME-Version: 1.0
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
Date:   Mon, 20 Apr 2020 17:39:02 -0500
Message-ID: <CAM2wg3RX8rKzFw+s=Z03gQpWsDcXQqhcan5vNRaw0BFz7URzFQ@mail.gmail.com>
Subject: Additional Crashmonkey Tests
To:     fstests@vger.kernel.org
Cc:     Jayashree Mohan <jayashree2912@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

I'm working with the Crashmonkey [1] team at UT, and I wanted to
follow up on an a patch [2] Jayashree sent a while back.  The
patch added a test combining 37 test cases for hard link behavior
into a single test. In that email, she noted there were also
similar Crashmonkey tests for other operations (falloc, unlink,
rename, etc.) that she could port if you all were interested. We
have now built an adapter that would allow us to port these
Crashmonkey tests over to xfstest.  Is this something that you
guys would find valuable?

Thanks,
Arvind Raghavan

[1] https://github.com/utsaslab/crashmonkey
[2] https://www.spinics.net/lists/fstests/msg10767.html
