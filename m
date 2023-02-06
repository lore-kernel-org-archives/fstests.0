Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86825C05027
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBFOx2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFOx1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 09:53:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12183D9
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 06:53:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E67B811B3
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 14:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B70AC433D2;
        Mon,  6 Feb 2023 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675695204;
        bh=YzaoS0t97+X8aqKQMiTVN61WvZ/yy3px1SeF7ylL8xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOw6PrKYJDG2DNeJ1PJiZZZEAwUT7BMio7akPji1RtEyjyqR/SeNjb9zSnEGRMnS3
         ZjO2RcTDj9JPxrZ9CSYC0LX0HvcLgJdGPhc5zAk2hSlMsYsqHOLiKCYrgxeL57H7+6
         YryI1ByjoOdF1TpalOnVWZVMabygznt+uynrDqlio+A/RynaLVS1eoRDAmTU4TgUfJ
         CQVl/kQgdLjEyVBWKHiH3cVdwuZVi2j5JMQIK7Gomz9voT/mzYJhMzDE0eCJij8tXZ
         MlDpUmQH/16JCXVFPUWfia+/N0q1WTqm3v0/o1hgv1x+9L+nzk2ZaunSZEZbaRGjFk
         geEDK1JU1wJbg==
Date:   Mon, 6 Feb 2023 15:53:19 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common: Chown mount even if already idmapped to account
 for remounts
Message-ID: <20230206145319.7eb2yltqqhu6q3s4@wittgenstein>
References: <20230203143545.23689-1-gniebler@suse.com>
 <20230203175437.30687-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203175437.30687-1-gniebler@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 03, 2023 at 06:54:37PM +0100, Gabriel Niebler wrote:
> This is a logical consequence of introducing the chown check in _idmapped_mount,
> since now a read-only mount can be made idmapped successfully. But if the mount
> is then remounted rw the chown never happens, as _idmapped_mount sees that it's
> already idmapped and bows out early.
> 
> This patch fixes that by simply moving the chown ahead of the idmapped check,
> so it will be performed in any case, even on already idmapped mounts.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!
