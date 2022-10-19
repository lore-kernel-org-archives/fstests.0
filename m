Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E751C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Oct 2022 02:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJSC26 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Oct 2022 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJSC24 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Oct 2022 22:28:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA486E318F
        for <fstests@vger.kernel.org>; Tue, 18 Oct 2022 19:28:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29J2SZDS002645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 22:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1666146517; bh=ujoQUjww6pMbAQaLOcgnB/jK9WWPVKDJEoQYNWw3wXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iM5HwVtDpRAlyIRNIWclk1maoXxjUGjyd1ynr8Q0H/PAbFqlYfmhHMzEqUu09k+5Q
         OStD3XeYfjZfM1tWXddrLPiLR/t26NRRb9Xyw/wRx8cX2YLXql6CQJAox7J1tzqMy/
         MA1PAlAyOBygQRvGWfZDgT5VGhLjPl/6pL21OCBxO4G0anr5ZIYyS7DSYsFh96pYQv
         /Plz9eOZm7qFdiwazpadSFWHttXVSRb33WqhhjNQcil7k/F4sb321UXQcEMxrMohMi
         HN6rXczZE+VPkBAk+uMrgkxDeXB2oOVK0sfcgN3hWBK+8fsfWyR7mU2WlExsuauAVr
         jnqK0bpZcJ2Iw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B1EC15C3AD1; Tue, 18 Oct 2022 22:28:35 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] Use grep -E instead of egrep
Date:   Tue, 18 Oct 2022 22:28:32 -0400
Message-Id: <166614650636.212506.7916545528316618508.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221018181626.154383-1-ebiggers@kernel.org>
References: <20221018181626.154383-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 18 Oct 2022 11:16:26 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Avoid some of the "egrep is obsolescent" warnings that the latest
> version of GNU grep prints.
> 
> 

Applied, thanks!

[1/1] Use grep -E instead of egrep
      commit: 34e81de235cf380d30082779aef5e6f50b9b9548

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
