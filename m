Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158DC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 11:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiETLkx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241967AbiETLkv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 07:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F5BCA0
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 04:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DCF661DAC
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0677DC385AA;
        Fri, 20 May 2022 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653046846;
        bh=KTfWH/fLSrjAPUGw0I5tecBfqy0F5Rkp0h+rivCvrnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MilavE2pkLcSKJGobUPWkSDFZA+V9ZP7yDsl4F6G+aWwCSJXdenPEn4t5Ic3BvzCw
         4ExhwutIIxDPlEfYV2eaSKe8mZhIUduLBog5nrMt3mF+tw9c9vDFTefQNXiDfVE+AM
         bZyexzDTtHRaDHZC1HYICFYDHYkQXqw5NXd+aFTLK9F6Ps9nkgnJfJIpd4iGcjqLwG
         Suqtf+87uVQxp9qjd0H/REfXQOSH6TFHduJVZc7mMFR9JvDLzNQ3cw5nxnx355OwF5
         IsiulRTwAJ6TltqE/CIZHznmhAbne5DiHKvqnNQJcqXqRlp+kXmw8fx5ioRg9ltC+N
         ddcx9+R72U3Fg==
Date:   Fri, 20 May 2022 13:40:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: tests should not source common/rc directly
Message-ID: <20220520114042.czadq2gpk4im7pos@wittgenstein>
References: <20220520012336.1542637-1-david@fromorbit.com>
 <20220520012336.1542637-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520012336.1542637-2-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 11:23:35AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> _begin_fstest() does this as every test needs it, so remove it from
> all the tests that source it a second time.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
