Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5117C5479D
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjAKUae (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjAKU2b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 15:28:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5032260
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 12:28:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2AB0344EB;
        Wed, 11 Jan 2023 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673468888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC/kGg8MoGFFYMopNXzajUBT1srAyaayoed3Pqm2o1Q=;
        b=aGg1F3WprvIRRvFPlijKJlm2uACM3DpjsQxUgmXHrIjl+XNlBHJxrlzXH5tBl0Fkpcf+t1
        OxBTaTyEmw2/Qh+TK3R5hXKu6a56yUiRy/NWWvMmphAl2s4oZ3ta/uynbKOalhGREVZEDx
        DBtDFJfB8SOxtKWoGWoCVL9bVkBfY1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673468888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC/kGg8MoGFFYMopNXzajUBT1srAyaayoed3Pqm2o1Q=;
        b=Qps7kIGkEVH7PAV9YBPCz+4RjEn5EEr6y6QYgyvs7OcXwzl6lcDg5IvRmbmOuefJQXNubn
        p48qHYEFK/kCcfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A3B01358A;
        Wed, 11 Jan 2023 20:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xM0FINgbv2OiSAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 11 Jan 2023 20:28:08 +0000
Date:   Wed, 11 Jan 2023 21:29:12 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/294: performance is unreasonably slow
Message-ID: <20230111212912.36a3a212@echidna.fritz.box>
In-Reply-To: <20230110224906.1171483-4-david@fromorbit.com>
References: <20230110224906.1171483-1-david@fromorbit.com>
        <20230110224906.1171483-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Dave!

On Wed, 11 Jan 2023 09:49:06 +1100, Dave Chinner wrote:

> From: Dave Chinner <dchinner@redhat.com>
> 
> This creates a bunch of files in a dir, then deletes 97% of them
> attempting to leave 1 allocated inode per inode chunk so that they
> aren't freed. Performance is badly limited by task creation and
> destruction for each inode created. Fix this by using "echo -n >
> file" rather than touch so that the shell creates the empty files
> without needing to fork/exec a separate task for each creation.
> 
> This reduces runtime from 45s down to 15s.

I see >7x improvement on a zram device, be it from a lower baseline :)

Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David
