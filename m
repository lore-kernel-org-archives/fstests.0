Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6959C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiF1SVu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiF1SVs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:21:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34417205D9
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:21:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SILgXI023727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440504; bh=kznytDLrEzPusFkNJE+HL6nTBh9QrClYKB0cBxWezfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=S4pB6vTlq+9NJVizDiC58tuWNFxd6hnJYYx+3hQPUUje2ACUXQfKVjqIQTM6WTmS5
         64aF5P2jCW4L35PsEh8sKLDyw8fTeZPemvHMa5Zx4pOTxkt45GcIKm/Yk3Tus/evRI
         T8vZo2Jie2v1UNNzpvDEwiw2ytFIYirDCrvrsxx4yKJiNtxFC5pkoslW6jnLOj+4TZ
         BAOJjTayBuThf2whOJeoGA+ghG4BOouIr6YyE47GSAHQ3eHAephycYwdvSrmzPZwiO
         bNRn2G/T5wWCERotymkyBji+oRY0xwuVQ6k0LOm13WLrm5EZzZzztqhzal6b+IqbHq
         04KSPyS8/0YtA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D3F9B15C4311; Tue, 28 Jun 2022 14:21:42 -0400 (EDT)
Date:   Tue, 28 Jun 2022 14:21:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4/045: clean up unnecessary arguments to
 _require_e2fsprogs
Message-ID: <YrtGtuqL+fUnv4rX@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-4-tytso@mit.edu>
 <20220628043716.6y667we64rehq5qr@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628043716.6y667we64rehq5qr@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:37:16PM +0800, Zorro Lang wrote:
> 
> This change is good, but the patch subject:
>   "ext4/045: clean up unnecessary arguments to _require_e2fsprogs"
> is a little weird, dut to it's not changing "_require_e2fsprogs" (and there's
> not _require_e2fsprogs).

I've replaced the commit description with:

ext4/045: _require_dumpe2fs doesn't take any arguments so remove them

	  		    	    	     - Ted
