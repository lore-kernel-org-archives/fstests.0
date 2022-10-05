Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4692C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Oct 2022 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJEPUZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJEPUU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Oct 2022 11:20:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2C1583B
        for <fstests@vger.kernel.org>; Wed,  5 Oct 2022 08:20:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w191so6650212pfc.5
        for <fstests@vger.kernel.org>; Wed, 05 Oct 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aNXVben6Hlwi8IipFu2cs8zeIg/J5CuZYE9y1PzYKaE=;
        b=fJQHBWfM9/yc68KqeV4eicXBE26Y8Y9EfNCSf8LGdcfUnae+u2Yf56l2GveiEZGR49
         t56xPyPZV9hJcLUHpvrt+SBZ/q5VZGlni7Hoh8JPD9ZCFWj7dI7t3kRDH/cJGoX4/fjq
         u0t/n86FL4uAnHP1YVtlHiQ5LplFlIyj2+wZHoWsjSQFAMBruDleN2oSFFReHQb6h3Q7
         GGbjgDUaIpKRF7M+dEzMn0W/SssFKyEjyA/3wm5y9lZVXIbxpKMFKCfIJX3F+Kd4kMHn
         vshju9jVKBXzMZ8BT0ksK3/vHRZdZ+wZTkcHkclcWQSRqn4doOfcFJhJ8b5ew2nKRhuC
         ZyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNXVben6Hlwi8IipFu2cs8zeIg/J5CuZYE9y1PzYKaE=;
        b=1QvLGoAcad5uqLo0JQ3SUsW25GCk41jI4bKvAq3h4RkZXIS65uYsi7d5sfpFHLyP+n
         kDDp25Hq3KBQWHmjzOM93nCHHyyIRzkZGaFbzptbSKOMkzsYEJkY5vzqhHRDujNGNd+i
         FArsJNv70wKKaESjo9AH3dcM4hCyVUo4mhgPfnveJlqOaEgqnII0DtVUWQXY1qbqFf4d
         D2A5lUL7LqqTi93ZLDA0Ze233atrjukXtCRTlXJdMyd5lJMfzMZx2oPmDbq63ZN27znO
         tlxnIm8DlcoMyQdPB44Xs7Bp2bZiOB3BGKWz9glE3xkO/r39B18/Mk/CC/jq9XVP6Jo0
         O/5w==
X-Gm-Message-State: ACrzQf0o3K5QjpyG0spBwh8Edmx1TdOS+tkVlPyuRKgiacvZstqE1Qkr
        RqkQryKIEZpTA9zhWlZNX6bKClNjC8Wlwdc2fN0+uTDF
X-Google-Smtp-Source: AMsMyM58DqzcIPnkM0m0fFKwQ/bhBZak0M81vWz3wbVB88d7UTFNgbQtVDuGihGd/qjuQK0OPKnd67sQZVB8Y/GGe1c=
X-Received: by 2002:a63:5b5c:0:b0:440:8531:d3f6 with SMTP id
 l28-20020a635b5c000000b004408531d3f6mr328765pgm.114.1664983212817; Wed, 05
 Oct 2022 08:20:12 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 5 Oct 2022 11:20:00 -0400
Message-ID: <CAN-5tyH_96dtqcoXukcf7msXc1zPzx6R-Z2PD_H1HM+J42F_uQ@mail.gmail.com>
Subject: question about applications that use sparse file function fallocate()
To:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Dear xfstest community,

I noticed that a number of tests are developed and utilized linux's
fallocate() function call (to preallocate space, punch holes etc). I
was hoping that somebody could be kind enough to provide some
non-xfstest examples of applications that use this function. I'm aware
that Microsoft's MSSQL running on linux would make fallocate() calls
to preallocate space (but it doesn't punch any holes for instance).
But I wonder if there are others?

Thank you for your feedback.

PS: please cc me in the reply as I'm not a subscriber.
