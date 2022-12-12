Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE92C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 01:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLLBmm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Dec 2022 20:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiLLBmi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Dec 2022 20:42:38 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEED2D1
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2022 17:42:35 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-417b63464c6so27356577b3.8
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2022 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7ew/4hxl9l+i9yI/2gBfS4IRXVTEqopdLwWcHmAqoI=;
        b=ldNabe3Lpz9qcMuxPUfsgQXPRntNvMnDws3YEh++U7vBYVx5YX15PuOKkmoPB5Cr1F
         avVlk2FUJisXfcFE24o/ibuiu5i9+5pKMi26inpFYvl10rOWpOVZXeZ62OGsGwJUsQUC
         oh3z3Po+to/fF+ZqOfv/xBo1Fww9PRUC39RA6nR3FKLVjiHdJHRzACX6soq0LFY4mQ0p
         h3dxdcLWxtZmHUaQctsVh+xhyIxDYZnVK+YfbjjFYx9HVUnDKWBMqhtaf22NEwspERtu
         6tpguXBoJOkvCo47EeO6gL+D2eW2+XnMeKTuCnT5stSPF3mvoa5J/VsLRdWs0XGrOG9q
         A6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7ew/4hxl9l+i9yI/2gBfS4IRXVTEqopdLwWcHmAqoI=;
        b=1jUViPGc6fajfd5WP3kZdy1eBiv90e4xl2AumRx+vZ//RjRui33y6Y9y0gFc2/XN9/
         qhBjaB0cAD1+kJgiyqidl4Z3152oGE5v/nmUB60qA1Gnot3Nj8mEt3wlnZxhsKLDoPlU
         00RBW3SuaTDsQCYt3xQYCLmpr2wjoThnc7aXtYR4E4BucOe4e3QWtSmIPhKKAFe4hWzM
         lYfdP0Hc5UDKypr+hNGlqOk1jlPVxoxXWp0hirI4erueLgPjletaLEODcxV1aEzuilAa
         rBgUCmwfHzzD2oePCsnXsGVA8O5KLsozRlJG3KD6sOfsAroxJ/TtWcwWWct16sjzJ7i0
         q3Xw==
X-Gm-Message-State: ANoB5pnUAaZ5ljsBkJrSyuUytJVw8Vq+/QHfoNt8YB3BjJYy/QPLjcQ7
        7n4WInh7oDPcx0+SZMwR/0Totg4LnCuo9NQFlCMeuFFX0R11lQ==
X-Google-Smtp-Source: AA0mqf72pAAOi8Gx7fHnKCg/3vR4WHmGGXwwMJMju8TnpvjhaLvvbdNzsZ9rhIJ2OtkJ48qN/ktKPLXE0LWLqNTJ9tY=
X-Received: by 2002:a81:7853:0:b0:392:b19b:47e9 with SMTP id
 t80-20020a817853000000b00392b19b47e9mr11152273ywc.252.1670809354554; Sun, 11
 Dec 2022 17:42:34 -0800 (PST)
MIME-Version: 1.0
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Mon, 12 Dec 2022 09:42:23 +0800
Message-ID: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
Subject: supporting overlay+tmpfs breaks check -n -overlay -g auto
To:     Baokun Li <libaokun1@huawei.com>, fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Bisecting points me to this commit:

commit 92fb58afaa2f38a9369ad5791a4cbf135545617d
Author: Baokun Li <libaokun1@huawei.com>
Date:   Wed May 11 16:34:04 2022 +0800

    common: xfstests support overlay+tmpfs


It breaks this command:
./check -n -overlay -g auto

As a result, it fails to show me the list of testcases.

Please help to check.

Thanks!
Murphy
