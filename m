Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E43C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Feb 2022 02:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiBBCst (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiBBCs0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Feb 2022 21:48:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7680C061757
        for <fstests@vger.kernel.org>; Tue,  1 Feb 2022 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvtlk6DETvqusEqxyYqKvItKs5iC4WHQnh/Uy2LgV0Q=; b=O2YSUb/TM3gjYiCvVrhOkRLKzD
        K+7ELgyXkk4hkyLLhCgm8OzBs3E1jneHJ9c3n1tam7KmJrb07SnxqKtf1Qg0uKxfNh11nJAFOr/bR
        I0C/ZdcVTvu3LPqOsPY0Ui+WMpNXdR2oUa8VVkaMAkB1Jw2I7wvTix2BQklh/NnB4nmHeTdRKSq0Q
        5OmR8Em7Pa5hEhIpWAbw7Rcv7YSvUQlrtPzIjeo6QvVj/VLu9bZJ53knUK3dSquDV0Py38AOij4Cg
        YHU1KvqlMirxgln872ZLzSOTGC+Qm2G1OvkQHM1BTSQpBreuqfoej7W5UyyHXWzzmQUzPx/TjU+d9
        dbL7o0Hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF5gL-00E1ge-3r; Wed, 02 Feb 2022 02:47:41 +0000
Date:   Tue, 1 Feb 2022 18:47:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] common: handle old versions of modprobe which don't
 support --help
Message-ID: <YfnwzZYGuf/WOz8B@bombadil.infradead.org>
References: <20220201231936.981003-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201231936.981003-1-tytso@mit.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 01, 2022 at 06:19:36PM -0500, Theodore Ts'o wrote:
> There exists versions of modprobe out there which are so old that
> modprobe --help isn't a thing.  They're certainly not going to support
> modprobe --remove-patiently, so test to make sure modprobe --help
> works to suppress a spurious warning.

Wow.

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Fixes: 405c21d40aa1 ("common/module: add patient module rmmod support")
> Reported-by: Leah Rumancik <leah.rumancik@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
