Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82835C43464
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 04:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222B32086A
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 04:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mivosw4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIUEN7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUEN7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 00:13:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0668C061755
        for <fstests@vger.kernel.org>; Sun, 20 Sep 2020 21:13:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p9so15742336ejf.6
        for <fstests@vger.kernel.org>; Sun, 20 Sep 2020 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xXw9rsvjUhKaYVTl3fcKgUe1QE2MPWX4MHKe0Nt6K0A=;
        b=Mivosw4g+s43enU2u7samVyRNH/2TNkwMeelMNXbzxbHZbWdE2Vxn212Fm4HXOL6MD
         ourKO6AcEnimrsp9SuhxlChlw1imfO+PnxxcmCYnSkiDW8CzTodRJLMyVe7Tir7bYfzA
         FTZ2WPq0GcAJ5bd8eDVZ0GLKxOi3LKlKPp8ByEi+0sAI1OCgVMOo7tmmuqLkr7YBpMPl
         G7uSp/fvNukSPvWHmputGNhnt5wIN+cYf4mm/62SINtXEk6Ri92MR0g8zx2Jf35THfzH
         xyP+Yw+uWgdDlnFu3+cNvzxxNZvHyBpfiMbvs1BvvLXRohNUR6DzdK0FHPAaFLNcMklV
         7w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xXw9rsvjUhKaYVTl3fcKgUe1QE2MPWX4MHKe0Nt6K0A=;
        b=dSVQ3lzf7WsOV56p6FsZiWZemeWXJqJ9JqO3/tqMGm0osgIt5O3DbeJY5ZZ5KjbCZj
         JZdLbQE/AfpX4UrYLiUA8QH7xUY0Jx5BVk+UozfHMovr/g2LunPnq15VBw/Ld/QBsMPV
         5C6hnUnlfgcquoF6/ij6XXR65+rHuYrMvmnt5T15yAIWf+19+zQoTJLfbCkCialGYmkP
         OpCOfopwnW0ER/OP9OvuqPPkgVMI9qFX9V6BHNxiTFDIpKnWCC38XgIOajRECAmDNSi3
         dFSgfEuwQ/vq4BtyD84q0il5QqtQR9sFMPuf7+icv1xGoq8HgqAe13fzKN4123g4Um6A
         hajw==
X-Gm-Message-State: AOAM531KhnH4pSBx6rgVVh/Dqb+pgN6yH5n4kS8BdX0I6AjrdLQa8/Xu
        qqvJo3LGofNGFFYqXnKmx+MaTlLDlY0dHUgV7RsUpkExruk=
X-Google-Smtp-Source: ABdhPJx6BYbigrYyKgIyjfHZ/IWNq8ZS2RPMsIQpoCK0ebt9ZXfkKZHinQLJ4AkT0SD6uEtUXWMBWC6Di0Q5Q/lj504=
X-Received: by 2002:a17:906:770c:: with SMTP id q12mr46725915ejm.518.1600661637323;
 Sun, 20 Sep 2020 21:13:57 -0700 (PDT)
MIME-Version: 1.0
From:   Zheng Wu <zhengwu0330@gmail.com>
Date:   Mon, 21 Sep 2020 12:13:44 +0800
Message-ID: <CADQqeeTOw9vXQ2dKQS1a9RLRVaD_4N6-d4+bcuSt1-zUTzoMWQ@mail.gmail.com>
Subject: The feature of Block size > PAGE_SIZE support
To:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi experts,

We know that the feature of Block size > PAGE_SIZE will be supported in XFS.
Just, I can't test successfully in the last version of Linux.

When is this feature of  Block size > PAGE_SIZE available in upstream?

Thanks.

Best Regards
Zheng Wu
