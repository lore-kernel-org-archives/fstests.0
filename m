Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EE151990
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297170; cv=none; b=fz96+WtLaudnZM2o3mLaYeiPV7qAyv5AqaTwn1OvUDjUwnN9sBpdJdoH7llPC70jFyYQ7bl5OGhVyQ36PjaXER78kvMW5lcd+HjhIx7tAIAYNuFi4NZreZ1l96qKRcjeYpib7KXODY9Lc9zn0XpE21D+EN2pjtk1paXzrEsGcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297170; c=relaxed/simple;
	bh=gRnYCy3DvomvqWbtKnCfD6lpOqN/3Vy6waQ7ojnGeTk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2/ihzO+ilt87jiIubWhtkUgexzIZVLO6LuDmGiGR77XwxrhuCjUyjEKVH8SubOxGI4MGYq15w5yt4kYQB6sdStHYu7dR2XaZYTimayHTO20NU9VsJkfIo1AJNV7yRNHPPoh83FrOpUB2xujxl7t0XRT/qlhvxNNfvZhD2PcDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3a3E4A9j; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3a3E4A9j"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so2530333a91.2
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297167; x=1741901967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3wE2ibZn5SufygRU4N/xIesL05h8ucm7NvbROm039k=;
        b=3a3E4A9jLbpQoXXAtX0FvC05M3eAEIXEExLV7FsiCSMKIrypZTvY7XIsU6OVqaTbm7
         CKTrzFHN5vUSzrdAfU0nqLgow41DH2QE+gWva5TP0cR8PhhhVkz7/IzPdTz6VDnNbz7U
         lP7cYfij4Za3NQbX8rVzEMxiUOYiwmI29URLObvF0KykWnmX5UNyoX9gcfujdNG3H1ho
         aysU98pZ+ggATlEQ73VOWZ5zUQ2xVZ5CwBLARD8lECQmBLzBEahF/8a/SRmmHyFPwdJE
         /A7RSCaCNalOYkW5hhV6k2jr8iMzONle+Y2BlIR7D54VUxWm04GHMtrsTXmcxdKIHWMW
         L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297167; x=1741901967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3wE2ibZn5SufygRU4N/xIesL05h8ucm7NvbROm039k=;
        b=xQfoPG2eI0LpJLHBh7TlPCddxjvLkYsGtCleZTh5JTnnzr+JKFFWldO0ZaCBKZEsL7
         MrmfLiU6WWZr5Yh4w/6dpeI/BT6omoKgUytRD/lWb+YsGfrjUv+n9EAoJV4ERtRgs7gC
         Il7JM3rge94MH2a7ecXCdx+3P46j7R4jFiSIbsE91QShnzQIXzP77fNmuSdXOVtCsMNT
         RLBccR0nW2SPfHMenaiqUng9Gk0ouzNuiCoPHlrSNinUvzY4aNj3w+TE1G5QqLJ89d9k
         OnePdtZo1pMEBknqG1vijBywwz2lCfxH9TJX/cUg9ch03+wUpcc2WYUh7oqwMOmlfsE7
         NhEw==
X-Gm-Message-State: AOJu0YwbeDU8DCY4h3a/5wWhMZGJDLbkvdOrME3XfMPZWi6K11yp5nfD
	sizKdnAiNy/Sb9jSosFGyZkuxtVPxoLzuOk2xjfR3kN/LGeSK31XMl9lZDhiOxAqbVay11d4deW
	N
X-Gm-Gg: ASbGncvnDzuq3FHCWOaEUuHb46suZDINqcWy5ncI+LmJAm7hvJhfwaoCwZEpvz9ZY/q
	aQDNsiz4apD5o8jW9ZVJTjJmN/btvHQPWntbbZLSc87QtiYxABz/l+rxq2Q/FXNFUZulcKslCWr
	9id3BNvDnWvY2z0ocdRhYkL7ZLn//t/lCFBUM77xQXTSokvklQDV2wuUxyCXjaJqiLKZKJ4Fgdd
	PEpyyU/E6b+W/HcqSdY0T6M/u20PZ95hHrZzKKeSCUMrYbQyqP1GFxjo9NJLEyijjbKvKKbD1DZ
	wHtdpAhThjCkCTv21VoTdUcAemoJJs9OawFOnKLDWWSgwn1QviFUgRGvpszVrGdAj1nGFL6ZXDp
	d1xWWLdlVSHCve/YC/rI=
X-Google-Smtp-Source: AGHT+IEUjcxwI6mG0oWTYzVwb51HUiLOUegszjHpEdbR5hciEfJuNmVvJvl9vK/fU5UVdfa5Nj7QAQ==
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2ff7cea9a99mr1489556a91.18.1741297167421;
        Thu, 06 Mar 2025 13:39:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75ccsm1738812a91.32.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:27 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRh-2hKy
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000Fvrc-3anL
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 5/5] fstests: remove old tools from tools directory
Date: Fri,  7 Mar 2025 08:34:50 +1100
Message-ID: <20250306213921.3769440-6-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

ag-wipe, db-walk, fs-walk and interop are all old 2000s era SGI QA
scripts that are either not usable anymore of have been superceded
by much more recent functionality.

interop only runs on machines with the host named "bruce" or
"whack", requires NFS mounts from a machine named "snort" and access
to a specific user's home dir. I know what all these were; they were
test and build machines in SGI's engineering office in Melbourne,
Australia. That went away in ~2009....

ag-wipe is unused and has been superceded by multiple different sets of
functionality (e.g. ./check --large-fs).

db-walk is unused by fstests and now is native xfs_db functionality.

fs-walk is dumping the md5sum and stat info of every file in a
directory heirachy and only used by the interop script....

Remove them all.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tools/ag-wipe | 171 ------------------------------------------------
 tools/db-walk | 178 --------------------------------------------------
 tools/fs-walk |  85 ------------------------
 tools/interop | 101 ----------------------------
 4 files changed, 535 deletions(-)
 delete mode 100755 tools/ag-wipe
 delete mode 100755 tools/db-walk
 delete mode 100755 tools/fs-walk
 delete mode 100755 tools/interop

diff --git a/tools/ag-wipe b/tools/ag-wipe
deleted file mode 100755
index 52acf0f80..000000000
--- a/tools/ag-wipe
+++ /dev/null
@@ -1,171 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
-#
-use strict;
-use IO::File;
-use Getopt::Std;
-#
-#
-# Modify a filesystem's superblock and AGF metadata structures
-# so that only a subset of the allocation groups will be used.
-# Intended use is in testing large virtual devices (eg. loop)
-# with extremely large filesystems, where we want to ensure
-# high allocation groups are used as much as possible (where
-# the block addresses are large).
-#
-
-my %opt;
-getopts('cf:l:qr:v', \%opt);
-
-die "Usage: $0 [-f AG] [-l AG] [-r bytes] [-cqv] device\n" unless (@ARGV == 1);
-my $device = shift @ARGV;
-die "$device: no such file\n" unless (-e $device);
-
-my $clearall = defined($opt{'c'}) ? 1 : 0;
-my $retain = defined($opt{'r'}) ? $opt{'r'} : -1;
-my $quiet = defined($opt{'q'}) ? 1 : 0;
-my $verbose = defined($opt{'v'}) ? 1 : 0;
-my $nagfirst = defined($opt{'f'}) ? $opt{'f'} : 0;
-my $naglast = defined($opt{'l'}) ? $opt{'l'} : 0;
-
-# 
-# "clearall" means clear everything barring the final AG.
-# "retain" means clearall and retain a specified amount in the
-# second-from-last AG as well (value is the number of bytes).
-# [NB: retain with a value of zero is now the same as clearall].
-# 
-if ($retain >= 0) {
-	$clearall = 1;
-}
-
-sub xfs_db {
-	my $xfsdb = 'xfs_db -x';
-	my %hash;
-
-	foreach (@_) {
-		$xfsdb .= ' -c ' . $_;
-	}
-	print $xfsdb, ' ', $device, "\n" if ($verbose);
-
-	die unless open(DB, "$xfsdb $device 2>/dev/null |");
-	while (<DB>) {
-		if (/^(\S+) = (.*)$/) {
-			print if ($verbose);
-			$hash{$1} = $2;
-		}
-	}
-	return %hash;
-}
-
-
-# 
-# Stage 1: Get control information from the superblock
-# 
-
-my @sbprint = ( '"print fdblocks"', '"print agcount"', '"print blocksize"' );
-my @agffree = ( '"print freeblks"' );
-
-my %sb = xfs_db 'sb', @sbprint;
-print "=== Initially ", $sb{'fdblocks'}, " blocks free across ",
-	$sb{'agcount'}, " AGs\n" unless $quiet;
-if ($clearall && ($nagfirst || $naglast)) {
-	print STDERR "  o Clearall/retain specified with first/last AG\n";
-	exit(1);
-}
-if ($nagfirst >= $sb{'agcount'}) {
-	print STDERR "  o First AG number is too large\n";
-	exit(1);
-}
-if ($naglast >= $sb{'agcount'}) {
-	print STDERR "  o Last AG number is too large\n";
-	exit(1);
-}
-if ($naglast - $nagfirst < 0) {
-	print STDERR "  o No AGs to clear\n";
-	exit(1);
-}
-if ($clearall) {
-	$naglast = $sb{'agcount'} - 2;
-	if ($retain > 0) {
-		my %check;
-
-		$naglast--;
-		$retain /= $sb{'blocksize'};	# convert to fsblocks
-		%check = xfs_db "'agf $naglast'", @agffree;
-		if ($check{'freeblks'} < $retain) {
-			print STDERR "  o Insufficient space to retain\n";
-			exit(1);
-		}
-	}
-}
-
-
-# 
-# Stage 2: Wipe out all completely masked allocation groups.
-# 
-
-my @agfprint = ( '"print freeblks"', '"print flcount"' );
-my @agfcommands = ( '"write freeblks 0"',
-			'"write longest 0"', '"write flcount 0"',
-			'"write bnolevel 1"', '"write cntlevel 1"',
-			'"write flfirst 0"', '"write fllast 0"' );
-my @bnoprint = ( '"addr bnoroot"', '"print numrecs"' );
-my @bnocommands = ( '"addr bnoroot"', '"write numrecs 0"',
-			'"write leftsib -1"', '"write rightsib -1"' );
-my @cntprint = ( '"addr cntroot"', '"print numrecs"' );
-my @cntcommands = ( '"addr cntroot"', '"write numrecs 0"',
-			'"write leftsib -1"', '"write rightsib -1"' );
-
-print "=== Wiping ", $naglast - $nagfirst + 1,
-	" AGs starting from AG #", $nagfirst, "\n" unless $quiet;
-
-my $ag = $nagfirst;
-while ($ag <= $naglast) {
-	print "  o AG#", $ag, " AGF fields\n" unless $quiet;
-
-	my %agf = xfs_db "'agf $ag'", @agfprint;
-	xfs_db "'agf $ag'", @agfcommands;
-
-	my $blockcnt = $agf{'freeblks'} + $agf{'flcount'};
-	$sb{'fdblocks'} -= $blockcnt;
-	print "     cleared ", $blockcnt, " blocks from AG#", $ag, "\n"
-		unless $quiet;
-
-	my %btree = xfs_db "'agf $ag'", @bnoprint;
-	xfs_db "'agf $ag'", @bnocommands, "'agf $ag'", @cntcommands;
-	print "     cleared ", $btree{'numrecs'}, " BNO/CNT btree recs in AG#",
-		$ag, "\n" unless $quiet;
-
-	$ag++;
-}
-
-
-# 
-# Stage 3: Wipe out any partially masked allocation group.
-# 
-
-if ($retain > 0) {
-	print "  o AG#", $ag, " AGF fields (partial)\n" unless $quiet;
-
-	my %ragf = xfs_db "'agf $ag'", '"print freeblks"',
-		'"addr bnoroot"', '"print recs[1].startblock"';
-	my $maskblks = $ragf{'freeblks'} - $retain;
-	my $newstart = $ragf{'recs[1].startblock'} + $maskblks;
-	xfs_db "'agf $ag'",
-		"'write freeblks $retain'", "'write longest $retain'",
-		"'agf $ag'", '"addr bnoroot"',
-		"'write recs[1].startblock $newstart'",
-		"'write recs[1].blockcount $retain'",
-		"'agf $ag'", '"addr cntroot"',
-		"'write recs[1].startblock $newstart'",
-		"'write recs[1].blockcount $retain'";
-
-	$sb{'fdblocks'} -= $maskblks;
-	print "     cleared ", $maskblks, " blocks from AG#", $ag, "\n"
-		unless $quiet;
-}
-
-print "=== Updating final freespace count, ", $sb{'fdblocks'}, " blocks\n"
-	unless $quiet;
-xfs_db "'sb 0'", "'write fdblocks $sb{'fdblocks'}'"
diff --git a/tools/db-walk b/tools/db-walk
deleted file mode 100755
index e09920559..000000000
--- a/tools/db-walk
+++ /dev/null
@@ -1,178 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# use db to try to traverse the entire filesystem starting at the root
-#
-my $device;
-my $rootino;
-my $agcount;
-my $versionnum;
-my $dir_version;
-my @dir_inodes;
-my @bmap_blocks;
-my @block_inodes;
-my $mode;
-
-sub db($)
-{
-    my ($args)=@_;
-    my ($ret);
-    
-    $ret=`xfs_db -r $args $device 2> /dev/null`;
-    die "ERROR executing xfs_db -r $args $device" if ($?);
-    
-    return $ret;
-}
-
-sub fmt($)
-{
-    my ($text)=@_;
-    my $c=0;
-    print "        ";
-    foreach (split("\n",$text)) {
-        s/^core\.//;
-        
-        if ($c+length($_) >= 70) {
-            $c=0;
-            print ",\n        ";
-        }
-        if ($c) {
-            print ", ";
-            $c+=2;
-        }
-        print "$_";
-        $c+=length($_)+2;
-    }
-    print "\n";
-}
-
-sub inode($)
-{
-    my ($num)=@_;
-    my ($t);
-    
-    @dir_inodes=();
-    
-    $t=db("-c \"inode $num\" -c \"print\"");
-    print "    *** Inode $num\n";
-    fmt($t);
-    
-    ($mode)= $t=~ /^core.mode = (\d+)$/m;
-    
-    if ($t=~ /a\.bmx/m) {
-        bmap("inode $num","attr");
-        foreach (@bmap_blocks) {
-            attr_block($_);
-        }
-    }
-    if (eval "$mode & 040000") {
-        if ( $t=~ /sfdir/m) {
-            while ($t=~ /inumber(?:\.i[48])? = (\d+)$/mg) {
-                push(@dir_inodes,$1);
-            }
-        }
-        if ( $t=~ /u\.bmx/m) {
-            bmap("inode $num","dir");
-            foreach (@bmap_blocks) {
-                dir_block($_);
-                push(@dir_inodes,@block_inodes);
-            }
-        }
-    } else {
-        bmap("inode $num","file") if ( $t=~ /u\.bmx/m);
-    }
-}
-
-sub bmap($$)
-{
-    my ($cmd,$type)=@_;
-    my ($t);
-    
-    @bmap_blocks=();
-    
-    $flag=($type eq "attr")?"-a":"";
-    
-    $t=db("-c \"$cmd\" -c \"bmap $flag\"");
-    print "    *** bmap $type $cmd\n";
-    fmt($t);
-    
-    if ($type eq "dir" || $type eq "attr") {
-        while ($t=~ /startblock (\d+) \(.+\) count (\d+)/mg) {
-            for ($b=$1;$b<$1+$2;$b++) {
-                push(@bmap_blocks,$b);
-            }
-        }
-    }
-}
-
-sub dir_block($)
-{
-    my ($num)=@_;
-    my ($t);
-    
-    @block_inodes=();
-    
-    $type=($dir_version==2)?"dir2":"dir";
-    
-    $t=db("-c \"fsblock $num\" -c \"type $type\" -c \"print\"");
-    print "    *** $type block $num\n";
-    # need to drop . and ..
-    ($self)= $t=~ /\[(\d+)\].name = \"\.\"/m;
-    ($parent)= $t=~ /\[(\d+)\].name = \"\.\.\"/m;
-    fmt($t);
-    
-    
-    while ($t=~ /\[(\d+)\].inumber = (\d+)/mg) {
-        next if (defined $self && $1 == $self);
-        next if (defined $parent && $1 == $parent);
-        push(@block_inodes, $2);
-    }
-}
-
-sub attr_block($)
-{
-    my ($num)=@_;
-    my ($t);
-    
-    $t=db("-c \"fsblock $num\" -c \"type attr\" -c \"print\"");
-    print "    *** attr block $num\n";
-
-    fmt($t);
-}
-
-sub sb($)
-{
-    my ($num)=@_;
-    my ($t);
-    
-    $t=db("-c \"sb $num\" -c \"print\"");
-    print "    *** SB $num\n";
-    fmt($t);
-    
-    ($rootino)= $t=~ /^rootino = (\d+)$/m;
-    ($agcount)= $t=~ /^agcount = (\d+)$/m;
-    ($versionnum)= $t=~ /^versionnum = (0x[\da-f]+)$/m;
-    $dir_version = (eval "$versionnum & 0x2000")?2:1;
-}
-
-die "Usage: $0 <XFS device>\n" unless (@ARGV == 1);
-
-$device=shift @ARGV;
-die "can't read $device\n" unless (-r $device);
-die "$device is not a block device\n" unless (-b _);
-
-chomp($HOST = `hostname -s`);
-
-print "*** db-walk host $HOST device $device\n";
-
-sb(0);
-for ($ag=1;$ag<$agcount;$ag++) {
-    sb($ag);
-}
-
-@inodes=($rootino);
-while ($_ = shift @inodes) {
-    inode($_);
-    push(@inodes,@dir_inodes);
-}
diff --git a/tools/fs-walk b/tools/fs-walk
deleted file mode 100755
index 918e1ad67..000000000
--- a/tools/fs-walk
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# traverse the entire filesystem dumping info.
-#
-use MD5;
-use Getopt::Std;
-
-my %opt;
-
-sub scan($)
-{
-    my ($file)=@_;
-    my ($md5)=new MD5;
-    my (@stat);
-
-    unless (@stat=lstat("$file")) {
-        printf("%-" . ($opt{v}?65:32) . "s $file\n", "!!! could not lstat");
-        return;
-    }
-
-    $stat[0]=$stat[8]=""; # wipe the device and access time
-    $md5->reset;
-    $md5->add(join(" ",@stat));
-    
-    print join(" ",@stat), "\n";
-    
-    if ($opt{v}) {
-        print $md5->hexdigest . " ";
-        $md5->reset;
-    }
-
-    if (-l "$file") {
-        if (!defined($link = readlink $file)) {
-            printf("%-32s $file\n", "!!! could not readlink");
-            return;
-        }
-        $md5->add($link);
-    } elsif (-f "$file") {
-        if (!open(FILE, "$file")) {
-            printf("%-32s $file\n", "!!! could not read");
-            return;
-        }
-        $md5->addfile(FILE);
-        close (FILE);
-    }
-    print $md5->hexdigest . " $file\n";
-}
-
-getopts('vs', \%opt);
-
-die "Usage: $0 <dir>\n" unless (@ARGV == 1);
-
-$dir=shift @ARGV;
-die "can't read $dir\n" unless (-r $dir);
-die "$dir is not a directory\n" unless (-d _);
-
-chomp($HOST = `hostname -s`);
-
-print "*** fs-walk host $HOST dir $dir\n";
-
-@todo=$dir;
-while ($dir = shift @todo) {
-    scan($dir);
-    unless (opendir(DIR,$dir)) {
-        printf("%-" . ($opt{v}?65:32) . "s $dir\n", "!!! could not opendir");
-        next;
-    }
-    unless (@all=readdir(DIR)) {
-        printf("%-" . ($opt{v}?65:32) . "s $dir\n", "!!! could not readdir");
-        next;
-    }
-    closedir(DIR);
-    @dirs=grep(-d "$dir/$_" && !-l "$dir/$_", @all);
-    foreach (@all) {
-        next if /^\.\.?$/;
-        scan("$dir/$_");
-    }
-    
-    foreach (grep(!/^\.\.?$/, @dirs)) {
-        push (@todo,"$dir/$_");
-    }
-}
-
diff --git a/tools/interop b/tools/interop
deleted file mode 100755
index dc1652c2b..000000000
--- a/tools/interop
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/usr/sbin/perl
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-sub setup()
-{
-    $PATH="$PATH:/usr/local/bin/ptools:/sbin:/usr/sbin";
-    $DISPLAY="clouds:0";
-    
-    if ("$HOST" eq "bruce") {
-        $TOOLS="/home/dxm/isms/slinx-xfs/cmd/xfs/tools";
-        $SCRATCH_DEV="/dev/sdf1";
-        $SCRATCH_MNT="/mnt/xfs3";
-        $MKFS="/sbin/mkfs -t xfs -f";
-        $SUDO="/home/dxm/su -c";
-        $MOUNT="/bin/mount -t xfs";
-        $UMOUNT="/bin/umount";
-        $MKFS_EXTRA="-f";
-    } elsif ("$HOST" eq "whack") {
-        $TOOLS="/hosts/snort/build1/people/dxm/isms/slinx-xfs/cmd/xfs/tools";
-        $SCRATCH_DEV="/dev/dsk/20000080e5114459/lun2s0/c2p1";
-        $SCRATCH_MNT="/lun2";
-        $MKFS="/sbin/mkfs";
-        $SUDO="su root -c";
-        $MOUNT="/sbin/mount -t xfs";
-        $UMOUNT="/sbin/umount";
-        $MKFS_EXTRA="";
-    } else {
-        die "unconfigured host \"$HOST\"\n"
-    }
-}
-
-sub run_no_check(@)
-{
-    system(@_);
-}
-
-sub run(@)
-{
-    system(@_)  == 0
-        || die "ERROR \"" . join(" ",@_) . "\" returned error\n";
-}
-
-sub run_expect_fail(@)
-{
-    system(@_)  == 0
-        && die "ERROR \"" . join(" ",@_) . "\" returned non-error\n";
-}
-
-sub umount_no_check()
-{
-    run_no_check("umount $SCRATCH_DEV");
-}
-
-sub umount()
-{
-    run("umount $SCRATCH_DEV");
-}
-
-sub mount($)
-{
-    my ($ops)=@_;
-    run("mount -t xfs $ops $SCRATCH_DEV $SCRATCH_MNT");
-}
-
-chomp($HOST=`hostname -s`);
-
-die "usage: $ARGV0 <operation> [parameters]\n" unless (scalar(@ARGV));
-print "*** $HOST: Interop started\n";
-print "    *** ", join(" ", @ARGV), "\n";
-
-setup();
-
-$op=shift(@ARGV);
-
-umount_no_check();
-
-if ($op eq "init") {
-
-    run("mkfs -t xfs $MKFS_EXTRA $SCRATCH_DEV");
-    
-} elsif ($op eq "test") {
-
-    run("xfs_repair -n $SCRATCH_DEV");
-    
-} elsif ($op eq "easy") {
-
-    mount("");
-    system("mount");
-    mkdir("$SCRATCH_MNT/fish",0777);
-    
-} elsif ($op eq "check") {
-
-    mount("-o ro");
-    system("cd $SCRATCH_MNT ; $TOOLS/fs-walk .");
-
-} else {
-    die "unknown operation \"$op\"\n";
-}
-
-umount_no_check();
-- 
2.45.2

